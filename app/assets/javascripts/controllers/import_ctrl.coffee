angular.module 'ImportApp'
  .controller 'ImportCtrl', ($scope, $interval, $timeout, $uibModalInstance, Upload, data)->
    $scope.interval = null
    $scope.progress = 0
    Upload.upload({
      url: "/operations",
      data: data
    }).progress (evt)->
      progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
      $scope.progress = progressPercentage
    .success (data, status, headers, config)->
      $scope.progress = 100.1
      $scope.companies = data.companies
      $scope.fails = data.fails
      $scope.successes = data.successes

    $scope.ok = () ->
      console.log 'ok'
      $uibModalInstance.close($scope.companies)

    $scope.cancel = () ->
      console.log 'cancel'
      if $scope.companies != null
        $uibModalInstance.close($scope.companies)
      else
        $uibModalInstance.dismiss('cancel')
        