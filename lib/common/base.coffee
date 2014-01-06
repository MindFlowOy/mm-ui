
###
*
*   Helper BaseClasses for controllers and services to avoid injection and intendation typo errors
*
*   Dependency - Function.prototype.bind or underscore/lodash
*
*   See http://www.devign.me/angular-dot-js-coffeescript-controller-base-class/
*
*   Example:
*
*   class QuestionCtrl extends Base
*        # second parameter is the name of the controller. Some coffeescript versions assign
*        # QuestionCtrl.name = 'QuestionCtrl', and some not. So, to be on the safe side, add the name
*        @register mmCtrls.controller, 'QuestionCtrl'
*        # list of dependencies to be injected
*        # each will be glued to the instance of the controller as a property
*        # e.g. @$scope, @QuestionSrv
*        @inject '$rootScope', '$scope', '$log', '$routeParams', 'QuestionSrv'
*        # initialize the controller
*        initialize: ->
*            @$log.info 'Question  Ctrl loaded'
*            @$scope.question = @QuestionSrv.get @$routeParams.questionId
*        # automatically glued to the scope, with the controller instance as the context/this
*        # so usable as <form ng-submit="submit()">
*        # methods that start with an underscore are considered as private and won't be glued
*         submit: ->
*            @QuestionSrv.post(@$scope.question).then =>
*                @$scope.question.answer = ""
*
*
*    Same in 'traditional' angular syntax:
*
*    mmCtrls.controller 'QuestionCtrl', [ '$rootScope', '$scope', '$log', '$routeParams', 'QuestionSrv'
*    ($rootScope, $scope, $log, $routeParams, QuestionSrv) ->
*        $log.info 'Question  Ctrl loaded'
*        $scope.question = QuestionSrv.get($routeParams.questionId)
*        submit: ->
*            QuestionSrv.post($scope.question).then =>
*                $scope.question.answer = ""
*    ]
*
###

Base = class @Base

    @register: (appModule, name) ->
        # app Module should be app.controller  app.service...
        appModule name || @name, @

    @inject: (args...) ->
        @$inject = args

    constructor: (args...) ->
        inject = undefined
        inject = @constructor.$inject if @constructor.$inject
        inject = @constructor.$get.$inject if @constructor.$get

        for key, index in inject
            @[key] = args[index]

        for key, fn of @constructor.prototype
            continue unless typeof fn is 'function'
            continue if key in ['constructor', 'initialize'] or key[0] is '_'
            @$scope[key] = @constructor.prototype[key] = fn.bind?(@) || _.bind(fn, @)

        @initialize?()


class BaseCtrl extends Base


module.exports =
    Ctrl: BaseCtrl
