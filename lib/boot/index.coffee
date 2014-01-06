# Ionic and angular components
require 'ionic'

# Application sub-components
require 'zones'
require 'summary'


###
*
* Main app
*
###
app = angular.module 'app', [ 'ionic', 'ngRoute', 'ngAnimate', 'appSrvs', 'appCtrls' ]


###
*
* App config
*
###
app.config ['$compileProvider', '$routeProvider', '$locationProvider',
($compileProvider, $routeProvider, $locationProvider) ->

    $compileProvider.aHrefSanitizationWhitelist /^\s*(https?|ftp|mailto|file|tel):/

    $routeProvider.when '/summary',
        templateUrl: '/template-summary.tpl.html'
        controller: 'SummaryCtrl'

    $routeProvider.when '/list',
        templateUrl: '/template-list.tpl.html'
        controller: 'ListCtrl'

    $routeProvider.when '/detail/:zoneId',
        templateUrl: '/template-detail.tpl.html'
        controller: 'DetailCtrl'

    $routeProvider.otherwise redirectTo: '/summary'

]

###
*
* App templates, routes and soem helpers
*
###
app.run ['$window', '$document', '$rootScope', '$log', '$q', '$location', '$templateCache',
($window, $document, $rootScope, $log, $q, $location, $templateCache) ->

    $templateCache.put '/template-summary.tpl.html', require('./template-summary')()
    $templateCache.put '/template-list.tpl.html', require('./template-list')()
    $templateCache.put '/template-detail.tpl.html', require('./template-detail')()

    $rootScope.$on '$routeChangeStart', (newRoute, oldRoute)->
        $log.info '$routeChangeStart'
    $rootScope.$on '$routeUpdate', (newRoute, oldRoute)->
        $log.info '$routeUpdate'
    $rootScope.$on '$routeChangeSuccess', (newRoute, oldRoute)->
        $log.info '$routeChangeSuccess!!'
        #$location.hash $routeParams.scrollTo
        #$anchorScroll()

    ###
    * Wrapper for angular.isArray, isObject, etc checks for use in the view by isArray(array),
    * isObject(object) etc (and from code: $scope.isArray())
    *
    * @method isArray, isObject...
    * @param type {string} the name of the check (casing sensitive)
    * @param value {string} value to check
    * @api public
    ###
    $rootScope.is = (type, value) ->
        angular['is' + type] value


    ###
    * Log debugging tool
    *
    * Allows you to execute log functions from the view by log() (and from code: $scope.log())
    * @method log
    * @param value {mixed} value to be logged
    * @api public
    ###
    $rootScope.log = (variable) ->
        console.log variable if console?.log

    ###
    * alert debugging tool
    *
    * Allows you to execute alert functions from the view by alert() ( and from code: $scope.alert())
    * @method alert
    * @param {string} text - text to be alerted
    * @api public
    ###
    $rootScope.alert = (text, needsTranslation) ->
        alert text

]



