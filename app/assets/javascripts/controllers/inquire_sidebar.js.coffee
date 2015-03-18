# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$(document).on('page:load', () ->
#  console.log "home::page:load was called"
#  $("#previousEntriesList").on('click', '.inquiry_element', (e) ->
#    console.log("previous element clicked: " + $(e.currentTarget).data('id'));
#    e.preventDefault();
#  );
#  $("#sharedEntriesList").on('click', '.inquiry_element', (e) ->
#    console.log("shared element clicked: " + $(e.currentTarget).data('id'));
#    e.preventDefault();
#  );
#);
#

@aminoApp.controller('inquireSidebar',  ['$scope', "$http", "$location", ($scope, $http, $location) ->

  $scope.init = () ->
    $http.get(Routes.api_v1_inquire_index_path()).success((data) ->
      $scope.inquiries.previous = data.previous
      $scope.inquiries.shared = data.shared
    ).error(() -> console.log arguments)

  $scope.inquiries =
    previous: []
    shared: []
  $scope.logClick = (entry) ->
    console.log "inquirySidebarController::clickHandler called with #{entry.id}"
  $scope.inquiry_click = (entry) ->
    console.log "inquirySidebarController::clickHandler called with #{entry.id}"
    $location.path(Routes.result_path(entry.id), {'rerun': 'true'}).replace()

])