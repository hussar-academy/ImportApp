angular.module 'ImportApp'
  .controller 'HomeCtrl', ($http, $scope, $filter, Operation, Upload, NgTableParams)->
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

    $scope.operations = []
    
    $scope.refreshOperationsList = () ->   
      Operation.all().success (response)->
        $scope.operations = response;
        $scope.tableParams.total(response.length)
        $scope.tableParams.reload()
        
    $scope.refreshOperationsList()
      
    $scope.$watch 'searchText', ->
      $scope.tableParams.reload()
      
    $scope.tableParams = new NgTableParams({
        count: 25
      },
      {
        total: $scope.operations.length
        getData: ($defer, params) ->  
          filteredData = $filter('filter')($scope.operations, filterOperations)
          if params.sorting() 
            $scope.orderedData = $filter('orderBy')(filteredData, params.orderBy())
          else
            $scope.orderedData = filteredData
          $scope.data = $scope.orderedData.slice((params.page() - 1) * params.count(),
            params.page() * params.count())
          $defer.resolve($scope.data)
       }
    )

    filterOperations = (operation) ->
      searchRegExp = new RegExp($scope.searchText)
      searchRegExp.test(operation.invoice_num) || searchRegExp.test(operation.status) ||
      searchRegExp.test(operation.reporter)