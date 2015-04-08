'use strict';

var toType = function(obj) {
    return ({}).toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()
}

var app = angular.module('cinch-controlpanel', [
    'ngRoute',
    'ngWebsocket',
    'controllers',
    'luegg.directives'
]);

app.config(['$routeProvider', '$locationProvider',
    function ($routeProvider, $locationProvider) {
        $routeProvider
            .when('/', {
                templateUrl: "index.html",
                controller: 'LogController'
            })
            .otherwise({redirectTo: '/'});

        /*$locationProvider.html5Mode({
            enabled: true
        });*/ //TODO: Enable HTML5 mode when done developing
    }
]);

var controllers = angular.module('controllers',[])

controllers.controller('LogController',['$scope', 'LogService', 'WebSocketService',
    function($scope, LogService, WebSocketService){
        $scope.log = LogService;


    }]);

app.factory('WebSocketService', ['$websocket', '$rootScope',
    function($websocket, $rootScope){
        var websocket = $websocket.$new({
            url: 'ws://' + window.location.host + '/websocket',
            reconnect: true,
            enqueue: true,
            protocols: []
        }).$on('$open', function(){
            console.log("WebSocket opened");
        }).$on('$close', function(){
            console.log("WebSocket closed");
        }).$on('$message', function(data){
            $rootScope.$digest();
        });

        return {
            /**
             * Subscribe to a websocket event
             * @param {string} event - The event you want to subscribe to
             * @param {function(data)} action - What you want done
             */
            subscribe: function(event, action) {
                websocket.$on(event, action);
                console.log("Subscribed to event: "+event);
            },
            unsubscribe: function(event){
                websocket.$un(event);
                console.log("All handlers for event: " + event + "have been destroyed");
            },
            send: function(event, data) {
                websocket.$emit(event, data);
            },
            connect: function() { websocket.$open() },
            disconnect: function() { websocket.$close() }
        }

    }]);

app.factory("LogService", ['WebSocketService',
    function(WebSocketService) {
        var log = [1,2,3];

        WebSocketService.subscribe('log', function(message){

            if (toType(message) === "string")
                log.push(message);
            else if (toType(message) === "array")
                Array.prototype.push.apply(log, message)
        });

        return {
            log: log
        };
}]);