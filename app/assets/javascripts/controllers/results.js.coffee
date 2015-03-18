@aminoApp.controller('ResultsCtrl', ['$scope','$rootScope', '$http', '$filter', ($scope, $rootScope, $http, $filter) ->
  $rootScope.inquiry = {}
  $rootScope.results = []
  $rootScope.queryResult = {}
  $rootScope.inquiry_path = ""
  $scope.initialize = (result_id) ->
    $scope.load_result(result_id)

  $scope.get_value = (feature) ->
    f_type = feature.type.toLowerCase()
    if f_type in ['nominal', 'restriction']
      feature.value
    else if f_type in ['ratio', 'interval']
      "#{feature.min} => #{feature.max}"
    else if f_type in ['date', 'datehour']
      "#{$filter('date')(feature.timestamp_from, 'short')} => #{$filter('date')(feature.timestamp_to, 'short')}"

  $scope.load_result = (result_id) ->
    $http.get(Routes.api_v1_result_path(result_id)).success((data) ->
      _.assign $rootScope.inquiry, data.hypothesis_at_runtime
      $rootScope.inquiry_path = Routes.inquire_path($scope.inquiry.id)
      $rootScope.results = data.result_set
      _.assign $rootScope.queryResult, data
    ).error((data) -> console.log arguments)

])

# a slight hack to allow us to have our control-bars be layout be defined in the application, while
# at the same time allow each page to determine its JS controller.
@aminoApp.controller('ResultsControlBarCtrl', ['$scope', '$rootScope', ($scope, $rootScope) ->

])

@aminoApp.controller('ResultsSubControlBarCtrl', ['$scope', '$rootScope', ($scope, $rootScope) ->

])