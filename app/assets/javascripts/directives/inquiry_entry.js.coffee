@aminoApp.directive('inquiryEntry',  ['$compile', '$timeout',
  ($compile, $timeout) ->
    return {
      restrict: "EA"
      scope:
        onClick: "=clickHandler"
        entry: "=entry"
      replace: true
      transclude: 'element'
      template: '<li class="inquiry_element" data-id="{{entry.id}}">
                   <a ng-href="{{get_result_url()}}" class="clearfix">
                     <span class="icon-check"></span>
                     <h2>{{entry.name}}</h2>
                     <p>{{entry.updated | date:\'short\'}}</p>
                   </a>
                 </li>'
      link: ($scope, element, attrs) ->
        $scope.get_result_url = () ->
          return Routes.result_path($scope.entry.id, {'rerun': 'true'})
    }
])