container     = "[data-id=widget-container-1]"
key           = "1243"
defaultValue  = "60714"
requestData   = {key: key, location: defaultValue}

setupOneContainer = ->
  setFixtures "<div data-id='widget-container-1'></div>"

newController = (container, value) ->
  new Weather.Widgets.Controller({container: container,key: key ,defaultValue: value})

describe "Weather.Widgets.Controller", ->
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
