angular.module('example', ['ngRoute'])
  .config([
      '$routeProvider',
      function ($routeProvider) {
        $routeProvider.when('/Welcome', {
          templateUrl: '/views/welcome'
        });
        $routeProvider.when('/Form', {
          templateUrl: '/views/form'
        });
        $routeProvider.when('/System', {
          templateUrl: '/views/system'
        });
    }])

  .controller('FormCtrl', [
    '$scope', '$http',
    function ($scope, $http) {
      $scope.saved = false;

      $http.get('/api/name')
        .success(function(data) {
          $scope.user = data;
        })
        .error(function(data, status, headers, config) {
          alert(status);
        })

      $scope.save = function() {
        $http.post('/api/name', this.user)
          .success(function(data) {
            $scope.saved = true;
            $scope.form.$setPristine();
          })
          .error(function(data, status, headers, config) {
            $scope.saved = false;
          })
      };
    }]);
