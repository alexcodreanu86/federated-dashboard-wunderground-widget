setupWidgetContainer = ->
  setFixtures " <div data-id='widget-container-1'></div>"

container = "[data-id=widget-container-1]"

describe "Weather.Widget.Controller", ->
  it "stores the container that it is initialized with", ->
    controller = new Weather.Widget.Controller(container)
    expect(controller.getContainer()).toEqual(container)

  it "sets itself up in the container when it is initialized with", ->
    setupWidgetContainer()
    controller = new Weather.Widget.Controller(container)
    controller.initialize()
    expect($(container)).not.toBeEmpty()
