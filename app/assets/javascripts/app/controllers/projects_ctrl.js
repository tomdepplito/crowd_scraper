//= require angular
//= require angular-route
'use strict';

var projects = angular.module('projects', [
  'ngResource',
  'ngRoute'
])
  .config(['$routeProvider', function($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: '../templates/projects/index.html.erb',
        controller: 'ProjectsCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  }]);

projects
  .factory('searchService', ['$http', '$q', '$timeout', function($http, $q, $timeout) {
    var searchResults = $q.defer();
    var getResults = function(data) {
      $timeout(function() {
        searchResults
          .resolve($http(
            {url: './search_projects.json',
             params: {input: data},
             method: 'GET'}
          )
          .success(function(data) {
            return data; 
          }));
      }, 100);
      return searchResults.promise;
    };

    return {
      getResults: getResults
    };
  }]);

projects
  .controller('ProjectsCtrl', ['$scope', '$http', 'searchService', function ($scope, $http, searchService) {
      $scope.search_input = '';
      $scope.search = function(searchInput) {
        searchService.getResults(searchInput)
          .then(function(result) {
            $scope.projects = result.data;
            $scope.search_input = '';
        });
      };
    }
  ]);
