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
    expect(controller.getContainer()).toEqual(container)

  it "stores a new instance of Weather.Widget.Display when instantiated", ->
    controller = newController(container)
    expect(controller.display).toBeDefined()

  it "initialize sets widget up in its container", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    expect($(container)).not.toBeEmpty()

  it "initialize is binding the controller", ->
    controller = newController(container)
    spy = spyOn(controller, 'bind')
    controller.initialize()
    expect(spy).toHaveBeenCalled()

  it "initialize is trying to display data for the default value", ->
    controller = newController(container)
    spy = spyOn(controller, 'displayDefault')
    controller.initialize()
    expect(spy).toHaveBeenCalled()

  it "initialize is setting the widget as active", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    expect(controller.isActive()).toBe(true)

  it "displayDefault is loading data when there is a default value", ->
    controller = newController(container, defaultValue)
    spy = spyOn(Weather.Widgets.API, 'getCurrentConditions')
    controller.displayDefault()
    expect(spy).toHaveBeenCalledWith(requestData, controller.display)

  it "displayDefault doesn't do anything when no default value is provided", ->
    controller = newController(container)
    spy = spyOn(Weather.Widgets.API, 'getCurrentConditions')
    controller.displayDefault()
    expect(spy).not.toHaveBeenCalled()

  it "bind is displaying the weather when the button is clicked", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    spy = spyOn(Weather.Widgets.API, 'getCurrentConditions')
    $("#{container} [name=weather-search]").val("60714")
    $("#{container} [data-id=weather-button]").click()
    expect(spy).toHaveBeenCalledWith(requestData, controller.display)

  it "bind removes the widget when close-widget button is clicked", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    $("#{container} [data-id=weather-close]").click()
    expect(container).not.toBeInDOM()

  it 'unbind is unbinding the weather button click processing', ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.unbind()
    $("#{container} [data-id=weather-button]").click()
    expect($('[data-id=weather-output]')).toBeEmpty()

  it "unbind is unbinding close widget button processing", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.unbind()
    $("#{container} [data-id=weather-close]").click()
    expect($(container)).not.toBeEmpty()

  it 'closeWidget is unbinding the controller', ->
    setupOneContainer()
    controller = newController(container)
    spy = spyOn(controller, 'unbind')
    controller.closeWidget()
    expect(spy).toHaveBeenCalled()

  it 'closeWidget is setting the widget as inactive', ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.closeWidget()
    expect(controller.isActive()).toBe(false)

  it "hideForm is hiding the form", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.hideForm()
    expect($("#{container} [data-id=weather-form]").attr('style')).toEqual('display: none;')

  it "showForm is showing the form", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.hideForm()
    controller.showForm()
    expect($("#{container} [data-id=weather-form]").attr('style')).not.toEqual('display: none;')

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

    it "will not refresh if widget is closed", ->
      controller = new Weather.Widgets.Controller({container: container,key: key ,refresh: true})
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      controller.closeWidget()
      expect(spy.calls.count()).toBe(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toBe(1)

    it "will execute only once if widget refresh is not true", ->
      controller = newController(container)
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      expect(spy.calls.count()).toBe(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toBe(1)

    it "will refresh only with the new search when a new one is submitted", ->
      controller = new Weather.Widgets.Controller({container: container,key: key ,refresh: true})
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      expect(spy).toHaveBeenCalledWith({key: key, location: 'Niles IL'}, controller.display)
      controller.displayCurrentConditions('London UK')
      nextRefresh = (60 - new Date().getSeconds()) * 1000
      jasmine.clock().tick(10 * oneMinute + 100)

    it "refresh will get new information every 10 minutes", ->
      setupOneContainer()
      controller = new Weather.Widgets.Controller({container: container,key: key ,refresh: true})
      controller.initialize()
      controller.displayCurrentConditions('Niles IL')
      nextRefresh = (60 - new Date().getSeconds()) * 1000
      jasmine.clock().tick(nextRefresh + 100)
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().tick(oneMinute + 100)
