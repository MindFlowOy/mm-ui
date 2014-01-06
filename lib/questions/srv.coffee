common = require 'common'

###
*
*
*
###
module.exports = mmSrvs = angular.module 'mmSrvs', []


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

