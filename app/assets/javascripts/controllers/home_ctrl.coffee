angular.module 'ImportApp'
  .controller 'HomeCtrl', ($http, $scope, $filter, $uibModal, Operation, Upload, NgTableParams)->

    $scope.companies = []

    Operation.all().success (resp)->
      $scope.companies = resp
      refreshOperationsList()

    $scope.importCsv = () ->
      modalInstance = $uibModal.open(
        animation: true
        size: 'lg'
        controller: 'ImportCtrl'
        templateUrl: 'import.html'
        resolve:
          data: ->
            file: $scope.file)
      modalInstance.result.then ((response) ->
        $scope.companies = response
        $scope.file = null
        refreshOperationsList()
        ), ->
          return   
    
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

    $scope.dataToCsv = (data) ->
      for row in data
        row.kind = $scope.categoriesToString(row.categories, ';')
      data

    $scope.headers = [
      'company',
      'invoice_num',
      'invoice_date',
      'operation_date',
      'amount',
      'reporter',
      'notes',
      'status',
      'kind'
    ]

    $scope.categoriesToString = (categories, separator) ->
      array = categories.map (item) ->
        item.name
      array.join(separator)