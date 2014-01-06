
###
*
*
*
###
summaryCtrl = ($rootScope, $scope, $location, $log) ->

    $log.info 'Summary Ctrl loaded'

    $scope.title = 'App'


    $scope.leftButtons = []
    ###
    [
        type: 'button-positive'
        content: "<i class='icon ion-navicon'></i>"
        tap: (e)->
            $log.log 'Nav'
    ]
    ###


    $scope.rightButtons = [
        type: 'button-clear'
        content: "<i class='icon ion-plus'></i>"
        tap: (e) =>
            $log.log 'Edit tap'
            $location.path("/list");

    ]


###
*
* Expose 'SummaryCtrl'
*
###
module.exports = angular.module('appCtrls').controller 'SummaryCtrl', [ '$rootScope', '$scope', '$location', '$log', summaryCtrl]
