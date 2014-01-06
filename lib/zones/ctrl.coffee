common = require 'common'
mmSrvs = require './srv'


###
*
*
*
###
listCtrl = ($rootScope, $scope, $log, ListSrv) ->
    $scope.title = 'Zones'
    $scope.zones = ListSrv.all()
    $log.info 'Zones List Ctrl loaded ', $scope.zones


###
*
*
*
###
detailCtrl = ($rootScope, $scope, $log, $routeParams, ListSrv) ->
    $scope.zone = ListSrv.get($routeParams.zoneId)
    $scope.title = $scope.zone.title
    $log.info 'Zones  Ctrl loaded'



###
*
* Expose 'ListCtrl' and DetailCtrl
*
###
module.exports = angular.module('appCtrls', ['appSrvs'])
.controller( 'ListCtrl', [ '$rootScope', '$scope', '$log', 'ListSrv', listCtrl ] )
.controller( 'DetailCtrl', [ '$rootScope', '$scope', '$log', '$routeParams', 'ListSrv', detailCtrl ] )

