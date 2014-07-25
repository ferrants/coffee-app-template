app = angular.module 'app', []

app.filter 'fromNow', () ->
  return (date) ->
    return moment(date).fromNow()

app.controller 'AppControl', ($scope, $http) ->
  $scope.app_data = {}
  $scope.data = () ->
    return $scope.app_data

  $scope.update_data = () ->
    $http.get('/api').success (data) ->
      $scope.app_data = data
