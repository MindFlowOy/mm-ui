###
*
* Expose 'SummaryCtrl' as the module
*
###
module.exports = mmCtrls = angular.module 'mmCtrls'

###
*
*
*
###
mmCtrls.controller 'SummaryCtrl', [ '$rootScope', '$scope', '$log'
($rootScope, $scope, $log) ->

    $log.info 'Summary Ctrl loaded'

    $scope.init = () ->
        $log.log 'Summary Ctrl init'
        return false
]
