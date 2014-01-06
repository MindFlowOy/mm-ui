common = require 'common'

###
*
*
*
###

listSrv = ($rootScope, $log) ->

    $log.info 'QuestionSrv  loaded'

    zones = [
        id: 0
        title: 'Food'
        description: 'Enter shortly after all eatings.'
        icon: 'ion-pizza'
        questions: [
            txt: 'Did you eat food?'
            kind: 'boolean'
        ,
            txt: 'Was it mostly plants?'
            kind: 'boolean'
        ,
            txt: 'Was it not too much?'
            kind: 'boolean'
        ]
    ,

        id: 1
        title: 'Exercise'
        description: 'Enter after all kind of phyisicall activities.'
        icon: 'ion-android-stopwatch'
        questions: [
            txt: 'Did you take exercise?'
            kind: 'boolean'
        ,
            txt: 'Was it more than 10min?'
            kind: 'boolean'
        ,
            txt: 'Did you get winded'
            kind: 'boolean'
        ]
    ,
        id: 2
        title: 'Emotional'
        description: 'Enter after any kind of emotional well-being like sleeping, theather..'
        icon: 'ion-heart'
        questions: [
            txt: 'Did you take relaxing activity?'
            kind: 'boolean'
        ,
            txt: 'Was it more than 10min?'
            kind: 'boolean'
        ,
            txt: 'Was it enjoyable?'
            kind: 'boolean'
        ]
    ]

    # Return/visible methods:
    all: ->
        zones

    get: (zoneId) ->
        zones[zoneId]


###
*
* Expose 'ListSrv'
*
###
module.exports = angular.module('appSrvs', []).factory 'ListSrv', [ '$rootScope', '$log', listSrv ]
