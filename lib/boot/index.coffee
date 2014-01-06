require 'ionic/js/ionic.js'
require 'ionic/js/angular/angular.js'
require 'ionic/js/angular/angular-route.js'
require 'ionic/js/angular/angular-animate.js'
require 'ionic/js/angular/angular-sanitize.js'
require 'ionic/js/angular/angular-touch.js'
require 'ionic/js/ionic-angular.js'
require 'questions'
require 'summary'

_appTemplate = require('./app')()
_questionTemplate = require('./question')()

###
*
*
*
###
mm = angular.module 'mm', [ 'ionic', 'ngRoute', 'ngAnimate', 'mmSrvs', 'mmCtrls' ]

###
*
*
*
###
mm.config ['$compileProvider', '$routeProvider', '$locationProvider',
($compileProvider, $routeProvider, $locationProvider) ->

    $compileProvider.aHrefSanitizationWhitelist /^\s*(https?|ftp|mailto|file|tel):/

    $routeProvider.when '/home',
        templateUrl: '/app.tpl.html'
        controller: 'SummaryCtrl'

    $routeProvider.when '/questions',
        templateUrl: '/app.tpl.html'
        controller: 'AppCtrl'

    $routeProvider.when '/question/:questionId',
        templateUrl: '/question.tpl.html'
        controller: 'QuestionCtrl'

    $routeProvider.otherwise redirectTo: '/home'

]

###
*
*
*
###
mm.run ['$window', '$document', '$rootScope', '$log', '$q', '$location', '$templateCache',
($window, $document, $rootScope, $log, $q, $location, $templateCache) ->

    $templateCache.put '/app.tpl.html', _appTemplate
    $templateCache.put '/question.tpl.html', _questionTemplate

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



