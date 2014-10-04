container     = "[data-id=widget-container-1]"
key           = "1243"
defaultValue  = "60714"
requestData   = {key: key, location: defaultValue}
weatherObj    = {
                display_location: {
                  full: "Niles IL"
                }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                local_time_rfc822: "Tue, 12 Aug 2014 19:58:23 -0500"
              }

setupOneContainer = ->
  setFixtures "<div data-id='widget-container-1'></div>"

newController = (container, value) ->
  new Weather.Widgets.Controller({container: container,key: key ,defaultValue: value})

describe "Weather.Widgets.Controller", ->
  controller = undefined
  afterEach ->
    controller.closeWidget()

  it "stores the container that it is initialized with", ->
    controller = newController(container)
    expect(controller.container).toEqual(container)

  describe '#initialize', ->
    it "sets widget up in its container", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      expect($(container)).not.toBeEmpty()

    it "binds the controller", ->
      controller = newController(container)
      spy = spyOn(controller, 'bind')
      controller.initialize()
      expect(spy).toHaveBeenCalled()

    it "displays data for the default value", ->
      controller = newController(container)
      spy = spyOn(controller, 'displayDefault')
      controller.initialize()
      expect(spy).toHaveBeenCalled()

    it "sets the widget as active", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      expect(controller.isActive()).toBe(true)

  describe '#displayDefault', ->
    it "loads data when there is a default value", ->
      controller = newController(container, defaultValue)
      spy = spyOn(Weather.Widgets.API, 'getCurrentConditions')
      controller.displayDefault()
      expect(spy).toHaveBeenCalledWith(requestData, controller.display)

    it "does NOT load data when no default value is provided", ->
      controller = newController(container)
      spy = spyOn(Weather.Widgets.API, 'getCurrentConditions')
      controller.displayDefault()
      expect(spy).not.toHaveBeenCalled()

  describe '#bind', ->
    it "displays the weather when the button is clicked", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      spy = spyOn(Weather.Widgets.API, 'getCurrentConditions')
      $("#{container} [name=widget-input]").val("60714")
      $("#{container} [data-name=form-button]").click()
      expect(spy).toHaveBeenCalledWith(requestData, controller.display)

    it "removes the widget when close-widget button is clicked", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      $("#{container} [data-name=widget-close]").click()
      expect(container).not.toBeInDOM()

  describe '#unbind', ->
    it 'unbinds the weather button click processing', ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      spy = spyOn($.prototype, 'unbind')
      controller.unbind()

      expect(spy).toHaveBeenCalledWith('submit')

    it "unbinds close widget button processing", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      controller.unbind()
      $("#{container} [data-name=widget-close]").click()
      expect($(container)).not.toBeEmpty()

  describe '#closeWidget', ->
    it 'unbinds the controller', ->
      setupOneContainer()
      controller = newController(container)
      spy = spyOn(controller, 'unbind')
      controller.closeWidget()
      expect(spy).toHaveBeenCalled()

    it 'sets the widget as inactive', ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      controller.closeWidget()
      expect(controller.isActive()).toBe(false)

  it "removeContent is removing the widget's content", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.removeContent()
    expect($(container)).not.toContainElement("[data-id=weather-widget-wrapper]")

  describe "displayCurrentConditions", ->
    controller = undefined
    oneMinute = 60000
    spy = undefined

    nextRefresh = ->
      (60 - new Date().getSeconds()) * 1000

    displayMockResponse = ->
      controller.display.showCurrentWeather(weatherObj)


    setSpy = ->
      spyOn(Weather.Widgets.API, 'getCurrentConditions').and.callFake(
        displayMockResponse
      )

    beforeEach ->
      jasmine.clock().install()
      spy = setSpy()

    afterEach ->
      controller.closeWidget()
      jasmine.clock().uninstall()

    it "does NOT refresh if widget is closed", ->
      controller = new Weather.Widgets.Controller({container: container,key: key ,refresh: true})
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      controller.closeWidget()
      expect(spy.calls.count()).toBe(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toBe(1)

    it "executes only once if widget refresh is not true", ->
      controller = newController(container)
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      expect(spy.calls.count()).toBe(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toBe(1)

    it "refreshes only with the new search when a new one is submitted", ->
      controller = new Weather.Widgets.Controller({container: container,key: key ,refresh: true})
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      expect(spy).toHaveBeenCalledWith({key: key, location: 'Niles IL'}, controller.display)
      controller.displayCurrentConditions('London UK')
      nextRefresh = (60 - new Date().getSeconds()) * 1000
      jasmine.clock().tick(10 * oneMinute + 100)

    it "gets new information every 10 minutes", ->
      setupOneContainer()
      controller = new Weather.Widgets.Controller({container: container,key: key ,refresh: true})
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      nextRefresh = (60 - new Date().getSeconds()) * 1000
      jasmine.clock().tick(nextRefresh + 100)
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().tick(oneMinute + 100)
