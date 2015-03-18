@aminoApp.controller('featuresSidebar',  ['$scope', '$rootScope', '$http', ($scope, $rootScope, $http) ->
  $scope.buckets = []
  $scope.bucket = null
  $scope.datasource = {name:'', id: ''}
  $scope.features = []

  $scope.$on 'datasource_change', (event, datasource) ->
    console.log "datasource_change"
    console.log datasource
    $scope.datasource = datasource
    $scope.updateBuckets()
    $scope.updateFeatures()

  $scope.$on 'select_bucket_by_id', (event, bucket_id) ->
    bucket = _.find($scope.buckets, {'id': bucket_id}) || {'id': bucket_id, 'name': ''}
    $scope.selected_bucket_change bucket


  $scope.updateFeatures = () ->
    $http.get(Routes.api_v1_feature_index_path({datasource_id: $scope.datasource.id}))
    .success((data) -> $scope.features = data)
    .error(() -> console.log arguments)

  $scope.add_feature = (event, feature_id) ->
    feature = _.find $scope.features, (feature) -> feature.id == feature_id
    $rootScope.$broadcast 'add_feature', feature
    event.preventDefault()

  $scope.selected_bucket_change = (bucket) ->
    $scope.bucket = bucket
    $rootScope.$broadcast 'select_bucket', $scope.bucket

  $scope.updateBuckets = () ->
    $http.get(Routes.api_v1_bucket_index_path({
      datasource_id: $scope.datasource.id
    })).success((data) ->
      $scope.buckets = data
      if $scope.bucket
        bucket =  _.find $scope.buckets, {'id': $scope.bucket.id}
        $scope.selected_bucket_change(bucket) if bucket
      return
    ).error(() -> console.log arguments)
])