angular.module('ImportApp', ['templates', 'ui.router', 'ngFileUpload'])
  .config ($provide, $httpProvider) ->
    # CSFR token
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      angular.element(document.querySelector('meta[name=csrf-token]')).attr('content')