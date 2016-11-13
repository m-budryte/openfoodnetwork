angular.module("admin.standingOrders").factory 'StandingOrders', ($q, StandingOrderResource) ->
  new class StandingOrders
    byID: {}
    pristineByID: {}

    index: (params={}, callback=null) ->
    	StandingOrderResource.index params, (data) =>
        @load(data)

    load: (standingOrders) ->
      for standingOrder in standingOrders
        @byID[standingOrder.id] = standingOrder
        @pristineByID[standingOrder.id] = angular.copy(standingOrder)