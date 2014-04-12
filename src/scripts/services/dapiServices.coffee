class DapiService
  @$inject: ['$http', '$routeParams']
  constructor: (@http, routeParams) ->
    useLocalServer = routeParams.localServer ? false
    base = if useLocalServer
      'http://localhost:8080'
    else
      'http://nestor.3dr.com'
    path = '/api/v1/'
    @apiBase = base + path

  urlBase: ->
    @apiBase + @endpoint

  get: ->
    @http.get(@urlBase())
    .then (results) ->
      results.data

  getId: (id) ->
    @http.get("#{@urlBase()}/#{id}")
    .then (results) ->
      results.data

  saveId: (id, obj) ->
    @http.post("#{@urlBase()}/#{id}", obj)
    .error (results, status) ->
      {results, status}

class UserService extends DapiService
  endpoint: "user"

class VehicleService extends DapiService
  endpoint: "vehicle"

class MissionService extends DapiService
  endpoint: "mission"

  getGeoJSON: (id) ->
    @http.get("#{@urlBase()}/#{id}/messages.geo.json")
    .then (results) ->
      results.data


module = angular.module('app')
module.service 'missionService', MissionService
module.service 'userService', UserService
module.service 'vehicleService', VehicleService