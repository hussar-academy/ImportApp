angular.module('ImportApp').factory 'Operation', ($http) ->
  all: () ->
    $http.get('/operations')