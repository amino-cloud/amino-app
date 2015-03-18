# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@aminoApp.controller('InquireControlBarCtrl', ['$scope','$rootScope', ($scope, $rootScope) ->
  $scope.name = ''
  $scope.justification = ''

  $scope.$watch 'name', (newValue) ->
    $rootScope.$broadcast 'inquire_name_change', newValue

  $scope.$watch 'justification', (newValue) ->
    $rootScope.$broadcast 'inquire_justification_change', newValue

  $scope.$on 'set_control_bar_data', (event, newValue) ->
    console.log newValue
    $scope.name = newValue.name
    $scope.justification = newValue.justification
])

@aminoApp.controller('inquire',  ['$scope','$rootScope', '$modal', '$http',
($scope, $rootScope, $modal, $http) ->
  $scope.selected_features = []
  $scope.bucket = {name: '', id: ''}
  $scope.datasource = {name: '', id:' ', description: ''}
  $scope.datasources = []
  $scope.inquire_name = ''
  $scope.inquire_justification = ''
  $scope.inquire_id = null
  $scope.next_instance_id = 0
  $scope.alerts = []

  $scope.initialize = (inquiry_id) ->
    $http.get(Routes.api_v1_datasource_index_path())
    .success( (data) ->
      $scope.datasources = data
      if $scope.datasource && (_.isEmpty($scope.datasource.name) && ! _.isEmpty($scope.datasource.id) )
        ds = _.find($scope.datasources, data.datasource_id)
        if ds
          $scope.datasource = ds
          $rootScope.$broadcast 'datasource_change', $scope.datasource
    ).error($scope.add_server_error)
    if inquiry_id
      $scope.load_inquiry inquiry_id
    else
      $scope.showModal()

  $scope.$on 'inquire_name_change', (event, newValue) -> $scope.inquire_name = newValue
  $scope.$on 'inquire_justification_change', (event, newValue) -> $scope.inquire_justification = newValue

  $scope.$on 'select_bucket', (event, bucket) ->
    console.log "select_bucket"
    console.log bucket
    $scope.bucket = bucket

  $scope.$on 'add_feature', (event, feature) ->
    $scope.add_feature feature

  $scope.remove_feature = (feature) ->
    _.remove $scope.selected_features, {instance_id: feature.instance_id}

  $scope.add_feature = (feature_box) ->
    if not _.isEmpty($scope.bucket.name) && not _.isEmpty(feature_box.id)
      $http.get(Routes.api_v1_featurebox_path(feature_box.id,  {
        bucket_name: $scope.bucket.name
        begin_range: feature_box.begin_range
        end_range: feature_box.end_range
      })).success((data) ->
        data.instance_id = $scope.next_instance_id
        $scope.selected_features.push data
        $scope.next_instance_id++
      ).error($scope.add_server_error)

  $scope.clear_features = () ->
    $scope.selected_features = []
    $scope.next_instance_id = 0

  $scope.load_inquiry = (inquiry_id) ->
    $http.get(Routes.api_v1_inquire_path(inquiry_id)).success((data) ->
      $scope.datasource = _.find($scope.datasources, data.datasource_id) || {'id': data.datasource_id}
      $scope.inquire_name = data.name
      $scope.inquire_justification = data.justification
      $scope.inquire_id = data.id
      $scope.selected_features = data.features
      $scope.bucket_id = data.bucket_id
      $rootScope.$broadcast 'select_bucket_by_id', $scope.bucket_id
      if $scope.datasource.name
        $rootScope.$broadcast 'datasource_change', $scope.datasource
      $rootScope.$broadcast 'set_control_bar_data', {justification: $scope.inquire_justification, name:$scope.inquire_name}
    ).error((data) -> console.log arguments)

  $scope.delete_inquiry = () ->
    return unless $scope.inquire_id
    $http.delete(Routes.api_v1_inquire_path($scope.inquire_id), {}).success((data) ->
        console.log "delete::Success"
        console.log arguments
        window.location = Routes.root_path()
    ).error($scope.add_server_error)

  $scope.save_and_execute = () ->
    error_reply = $scope.add_server_error
    successful_reply = (data) ->
      console.log "save_and_execute::Success"
      console.log arguments
      $scope.execute_inquiry(data)

    data = {
      datasource: _.pick($scope.datasource, ['name', 'id'])
      bucket: _.pick($scope.bucket, ['name', 'id'])
      features: _.map $scope.selected_features, (val) ->
        {
        name: val.feature.name
        type: val.feature.type
        id: val.id
        begin_range: val.begin_range
        end_range: val.end_range
        }
      name: $scope.inquire_name
      justification: $scope.inquire_justification
    }

    if not $scope.inquire_id
      $http.post(Routes.api_v1_inquire_index_path(), data, {}).success(successful_reply).error(error_reply)
    else
      $http.put(Routes.api_v1_inquire_path($scope.inquire_id), data, {}).success(successful_reply).error(error_reply)

  $scope.execute_inquiry = (inquiry) ->
    $http.post(Routes.api_v1_result_index_path(), {
      inquiry_id: inquiry.id
      justification: inquiry.justification
      max_results: 1000
    }, {}).success((data) ->
      window.location = Routes.result_path(data.id)
      data.id
    ).error($scope.add_server_error)

  # Initial modal dialog to choose datasource is below

  $scope.datasource_change = () ->
    $rootScope.$broadcast('datasource_change', $scope.datasource)

  $scope.add_alert = (alert_message, alert_type) ->
    $scope.alerts.push {type: alert_type, msg: alert_message}

  $scope.add_server_error = (server_error) ->
    $scope.add_alert server_error.error, 'danger'

  $scope.close_alert = (index) -> $scope.alerts.splice index, 1

  modalInstanceCtrl = ['$scope', '$modalInstance', ($childScope, $modalInstance) ->
    $childScope.ok = (datasource) ->
      $scope.datasource = datasource
      $modalInstance.close datasource
    $childScope.cancel = () -> $modalInstance.dismiss 'cancel'
    $childScope.selected_datasource_change = (datasource) ->
      $scope.datasource = datasource
  ]

  modalConfirmDeleteDlg = ['$scope', '$modalInstance', ($childScope, $modalInstance) ->
    $childScope.ok = () -> $modalInstance.close 'OK'
    $childScope.cancel = () -> $modalInstance.dismiss 'cancel'
  ]

  $scope.showModal = () ->
    modalInstance = $modal.open
      templateUrl: 'myModalContent.html'
      controller: modalInstanceCtrl
      size: 'lg'
      scope:$scope
    modalInstance.result.then $scope.datasource_change, null

  $scope.confirm_inquiry_delete = () ->
    modalInstance = $modal.open
      templateUrl: 'confirmInquiryDeleteModal.html'
      controller: modalConfirmDeleteDlg
      size: 'lg'
      scope:$scope
    close_action = () -> $scope.delete_inquiry()
    modalInstance.result.then close_action, null
])