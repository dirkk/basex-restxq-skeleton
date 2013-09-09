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
        $routeProvider.when('/User', {
          templateUrl: '/views/user'
        });
    }])

  .controller('FormCtrl', [
    '$scope', '$http',
    function ($scope, $http) {
      $http.get('/api/users')
        .success(function(data) {
          $scope.users = data.users;
        })
        .error(function(data, status, headers, config) {
          alert(status);
        })

      $scope.add = function() {
        $http.post('/api/user', this.user)
          .success(function(data) {
            $scope.users.push(data);
          })
          .error(function(data, status, headers, config) {
            alert(status);
          })
      };

      $scope.delete = function() {
        var id = this.user.id;
        $http.delete('/api/user/' + this.user.id)
          .success(function(data) {
            for (var i = 0; i < $scope.users.length; ++i) {
              if ($scope.users[i].id == id)
                $scope.users.splice(i, 1);
            }
          })
          .error(function(data, status, headers, config) {
            alert(status);
          })
      };
    }])

  .controller('UserCtrl', [
    '$scope', '$http',
    function ($scope, $http) {

      $http.get('/api/is-loggedin')
        .success(function(data) {
          $scope.loggedIn = data.result;
          if (data.result) {
            $scope.time = data.time;
          }
        })
        .error(function(data, status, headers, config) {
        });

      $scope.login = function() {
        $http.get('/api/login/' + this.user.name + '/' + this.user.password)
          .success(function(data) {
            $scope.loggedIn = data.result;
            if (data.result) {
              $scope.time = data.time;
            } else {
              alert("Login incorrect");
            }
          })
          .error(function(data, status, headers, config) {
          })
      };

      $scope.logout = function() {
        $http.get('/api/logout/')
          .success(function(data) {
            $scope.loggedIn = !data.result;
          })
          .error(function(data, status, headers, config) {
          })
      };
    }]);
