angular.module('ImportApp').directive 'progressWheel', ($timeout, $interval, $state) ->
  restrict: 'A'
  scope:
    progress: "=progressWheel"
  link: (scope, element, attrs) ->
    circle = new (ProgressBar.Circle)(element[0],
      color: '#FCB03C'
      strokeWidth: 3
      trailWidth: 2
      duration: 1500
      text:
        value: '0'
        style:
          fontSize: '30px'
      step: (state, bar) ->
        if bar.value() == 1
          bar.setText "Uploading file #{(bar.value() * 100).toFixed(0)}%"
          if !scope.interval?
            dots = "."
            scope.interval = $interval ()=>
              if dots.length == 4
                dots = ""
              bar.setText("Processing file" + dots)
              dots = dots + "."
            , 1000
        else if bar.value() == 1.001
          console.log 'finish'
          bar.setText("Imported")
          $timeout ()->
            $interval.cancel(scope.interval)
        else
          bar.setText "Uploading file #{(bar.value() * 100).toFixed(0)}%"
        return
    )

    scope.$watch 'progress', (newVal)->
      circle.animate(newVal/100)