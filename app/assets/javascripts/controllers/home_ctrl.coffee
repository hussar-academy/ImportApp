angular.module 'ImportApp'
  .controller 'HomeCtrl', ($http, $scope, Operation, Upload)->
    $scope.importCsv = () ->
      if $scope.form.file.$valid and $scope.file
        $scope.upload $scope.file

    $scope.upload = (file) ->
      Upload.upload(
        url: 'operations'
        data:
          file: file).then (resp) ->
          console.log 'Success ' + resp.config.data.file.name + 'uploaded. Response: ' + resp.data
        (resp) ->
          console.log 'Error status: ' + resp.status
        (evt) ->
          progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
          console.log 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name
