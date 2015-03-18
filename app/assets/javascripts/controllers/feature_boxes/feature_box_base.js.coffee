@aminoApp.controller('FeatureBoxBaseCtrl',  ['$scope','$rootScope', '$modal', '$http', 'filterFilter',
($scope, $rootScope, $modal, $http, filterFilter) ->
  $scope.feature_box =
    begin_range: ''
    end_range: ''
    id: ''
    feature:
      id: ''
      uniqueness: 0
      count: 0
      allowed_values: []


  $scope.initialize = (model) ->
    $scope.feature_box = model

  $scope.update_feature = () ->
    if not _.isEmpty($scope.bucket.name) && not _.isEmpty($scope.feature_box.id)
      $http.get(Routes.api_v1_featurebox_path($scope.feature_box.id, {
        bucket_name: $scope.bucket.name
        begin_range: $scope.feature_box.begin_range
        end_range: $scope.feature_box.end_range
      })).success((data) ->
        _.assign $scope.feature_box, data
      ).error(() -> console.log arguments)

  $scope.template_file_url = () ->
    '/templates/feature_boxes/' + $scope.feature_box.feature.type.toLowerCase() + '.html'

  $scope.remove_feature = () ->
    $scope.$parent.remove_feature($scope.feature_box)

  $scope.reset_stats = () ->
    $scope.feature_box.feature.uniqueness = 0
    $scope.feature_box.count = 0




  # nominal feature type
  $scope.typeahead_values = (filter_by) ->
    filterFilter($scope.feature_box.feature.allowed_values, filter_by)

  $scope.typeahead_select_value = (item) ->
    console.log "feature_typeahead_on_select"
    console.log arguments
    if (item in $scope.feature_box.feature.allowed_values)
      console.log "update_feature"
      $scope.feature_box.begin_range = item
      $scope.feature_box.end_range = item
      $scope.update_feature()
    else
      console.log "reset_feature"
      $scope.reset_stats()
])