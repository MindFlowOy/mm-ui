
assert = require 'assert'
_ionic = require 'ionic'
_angular = require 'ionic/js/angular/angular.js'
_router = require 'ionic/js/angular/angular-route.js'
_animate = require 'ionic/js/angular/angular-animate.js'
_sanitize = require 'ionic/js/angular/angular-sanitize.js'
_touch = require 'ionic/js/angular/angular-touch.js'
_ionicAngular = require 'ionic/js/ionic-angular.js'

_appTemplate = require('./app')()
_petTemplate = require('./pet')()


client = angular.module("starter", [ "ionic", "ngRoute", "ngAnimate", "starter.services", "starter.controllers" ])

client.config ['$compileProvider', '$routeProvider', '$locationProvider', ($compileProvider, $routeProvider, $locationProvider) ->
    $compileProvider.aHrefSanitizationWhitelist /^\s*(https?|ftp|mailto|file|tel):/

    $routeProvider.when "/home",
        templateUrl: "/app.tpl.html"
        controller: "AppCtrl"

    $routeProvider.when "/pet/:petId",
        templateUrl: '/pet.tpl.html'
        controller: "PetCtrl"

    $routeProvider.otherwise redirectTo: "/home"

]

client.run [ "$templateCache", ($templateCache) ->
  $templateCache.put "/app.tpl.html", _appTemplate
  $templateCache.put "/pet.tpl.html", _petTemplate
]

angular.module("starter.controllers", []).controller("AppCtrl", ($scope) ->
    console.log "Main AppCtrl"
).controller("PetsTabCtrl", ($scope, Pets) ->
    $scope.pets = Pets.all()
    $scope.$on "tab.shown", ->
        console.log "tab show"
    $scope.$on "tab.hidden", ->
        console.log "tab hide"
).controller "PetCtrl", ($scope, $routeParams, Pets) ->
      $scope.pet = Pets.get($routeParams.petId)


angular.module("starter.services", []).factory "Pets", ->
    pets = [
        id: 0
        title: "Cats"
        description: "Furry little creatures. Obsessed with plotting assassination, but never following through on it."
    ,
        id: 1
        title: "Dogs"
        description: "Lovable. Loyal almost to a fault. Smarter than they let on."
    ,
        id: 2
        title: "Turtles"
        description: "Everyone likes turtles."
    ,
        id: 3
        title: "Sharks"
        description: "An advanced pet. Needs millions of gallons of salt water. Will happily eat you."
    ]

    all: ->
        pets

    get: (petId) ->
        pets[petId]
