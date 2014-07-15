weatherObj = {  current_observation: {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                }
              }

setupOneContainer = ->
  setFixtures "<div data-id='widget-container-1'></div>"

container = "[data-id=widget-container-1]"

newController = (container) ->
  new Weather.Widget.Controller(container, "1243")

describe "Weather.Widget.Controller", ->
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

  it "bind is displaying the weather when the button is clicked", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    spy = spyOn(Weather.API, 'getCurrentConditions')
    $("#{container} [name=weather-search]").val("Niles IL")
    $("#{container} [data-id=weather-button]").click()
    data = {key: '1243', zipcode: 'Niles IL'}
    expect(spy).toHaveBeenCalledWith(data, controller.display)

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
