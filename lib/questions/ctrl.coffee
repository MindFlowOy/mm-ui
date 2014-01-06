common = require 'common'
mmSrvs = require './srv'


###
*
* Expose `debug()` as the module
*
###
module.exports = mmCtrls = angular.module 'mmCtrls', ['mmSrvs']

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
        $log.log 'tab show'
    $scope.$on 'tab.hidden', ->
        $log.log 'tab hide'

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
