_ionic = require 'ionic/js/ionic.js'
_angular = require 'ionic/js/angular/angular.js'
_router = require 'ionic/js/angular/angular-route.js'
_animate = require 'ionic/js/angular/angular-animate.js'
_sanitize = require 'ionic/js/angular/angular-sanitize.js'
_touch = require 'ionic/js/angular/angular-touch.js'
_ionicAngular = require 'ionic/js/ionic-angular.js'

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



###
*
*
*
###
mmSrvs = angular.module 'mmSrvs', []

###
*
*
*
###
mmSrvs.factory 'QuestionSrv', [ '$rootScope', '$log'
($rootScope, $log) ->

    $log.info 'QuestionSrv  loaded'

    questions = [
        id: 0
        title: 'Cats'
        description: 'Furry little creatures. Obsessed with plotting assassination, but never following through on it.'
    ,
        id: 1
        title: 'Dogs'
        description: 'Lovable. Loyal almost to a fault. Smarter than they let on.'
    ,
        id: 2
        title: 'Turtles'
        description: 'Everyone likes turtles.'
    ,
        id: 3
        title: 'Sharks'
        description: 'An advanced pet. Needs millions of gallons of salt water. Will happily eat you.'
    ]

    # Return/visible methods:
    all: ->
        questions

    get: (questionId) ->
        questions[questionId]
]

###
*
*
*
###
mmCtrls = angular.module 'mmCtrls', ['mmSrvs']

###
*
*
*
###
mmCtrls.controller 'AppCtrl', [ '$rootScope', '$scope', '$log'
($rootScope, $scope, $log) ->

    $log.info 'App Ctrl loaded'

    $scope.init = () ->
        $log.log 'App Ctrl init'
        return false
]

###
*
*
*
###
mmCtrls.controller 'QuestionListCtrl', [ '$rootScope', '$scope', '$log', 'QuestionSrv'
($rootScope, $scope, $log, QuestionSrv) ->

    $log.info 'Question List Ctrl loaded'

    $scope.questions = QuestionSrv.all()

    $scope.$on 'tab.shown', ->
        console.log 'tab show'
    $scope.$on 'tab.hidden', ->
        console.log 'tab hide'

]

###
*
*
*
###
mmCtrls.controller 'QuestionCtrl', [ '$rootScope', '$scope', '$log', '$routeParams', 'QuestionSrv'
($rootScope, $scope, $log, $routeParams, QuestionSrv) ->

    $log.info 'Question  Ctrl loaded'

    $scope.question = QuestionSrv.get($routeParams.questionId)

]
