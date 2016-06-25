angular.module 'ImportApp'
  .controller 'HomeCtrl', ($http, $scope, $filter, Operation, Upload, NgTableParams)->

    $scope.companies = []

    Operation.all().success (resp)->
      $scope.companies = resp
      refreshOperationsList()

    $scope.importCsv = () ->
      if $scope.form.file.$valid and $scope.file
        $scope.upload $scope.file

    $scope.upload = (file) ->
      Upload.upload(
        url: 'operations'
        data:
          file: file).then (resp) ->
        console.log resp
        $scope.companies = resp.data
        refreshOperationsList()
        (resp) ->
          console.log 'Error status: ' + resp.status
        (evt) ->
          progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
          console.log 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name
      
    
    refreshOperationsList = () ->  
      for company in $scope.companies
        company.tableParams = initializeTableParams(company.operations)
        company.tableParams.reload()
        
      
    $scope.$watch 'searchText', ->
      for company in $scope.companies
        company.tableParams.reload()
      
    initializeTableParams = (collection) ->
      new NgTableParams({
          count: 25
        },
        {
          total: collection.length
          getData: ($defer, params) ->  
            filteredData = $filter('filter')(collection, filterOperations)
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
      searchRegExp.test(operation.reporter) || searchRegExp.test(operation.categories)