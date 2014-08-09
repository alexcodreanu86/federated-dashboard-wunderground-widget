resetWidgetsContainer = ->
  Weather.Controller.widgets = []

setSandbox = ->
  setFixtures(sandbox())

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

describe "Weather.Controller", ->
  it "widgets container is empty on initialization", ->
    resetWidgetsContainer()
    container = Weather.Controller.getWidgets()
    expect(container.length).toBe(0)

  it "setupWidgetIn is setting up a widget instance in the desired element", ->
    resetWidgetsContainer()
    setSandbox()
    Weather.Controller.setupWidgetIn('#sandbox', "123456")
    html = $('#sandbox')
    expect(html).toContainElement('[name=weather-search]')
    expect(html).toContainElement('[data-id=weather-button]')
    expect(html).toContainElement('[data-id=weather-output]')

  it "setupWidgetIn is adding the initialized widget to the widgets container", ->
    resetWidgetsContainer()
    setSandbox()
    Weather.Controller.setupWidgetIn('#sandbox', "123456")
    expect(Weather.Controller.getWidgets().length).toEqual(1)

  it "hideForms is hiding the forms of all the widgets that are initialized", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Weather.Controller.setupWidgetIn(container1, "123456")
    Weather.Controller.setupWidgetIn(container2, "123456")
    Weather.Controller.hideForms()
    expect($("#{container1} [data-id=weather-form]").attr('style')).toEqual('display: none;')
    expect($("#{container2} [data-id=weather-form]").attr('style')).toEqual('display: none;')

  it "showForms is showing the forms of all the widgets that are initialized", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Weather.Controller.setupWidgetIn(container1, "123456")
    Weather.Controller.setupWidgetIn(container2, "123456")
    Weather.Controller.hideForms()
    Weather.Controller.showForms()
    expect($("#{container1} [data-id=weather-form]").attr('style')).not.toEqual('display: none;')
    expect($("#{container2} [data-id=weather-form]").attr('style')).not.toEqual('display: none;')

  it "closeWidgetInContainer will eliminate the widget from the given container", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Weather.Controller.setupWidgetIn(container1, "123456")
    Weather.Controller.setupWidgetIn(container2, "123456")
    Weather.Controller.closeWidgetInContainer(container1)
    expect($("#{container1} [data-id=weather-form]")).not.toBeInDOM()
    expect($("#{container2} [data-id=weather-form]")).toBeInDOM()

  it "closeWidgetInContainer will remove the widget from the widgets container", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Weather.Controller.setupWidgetIn(container1, "123456")
    Weather.Controller.setupWidgetIn(container2, "123456")
    Weather.Controller.closeWidgetInContainer(container1)
    expect(Weather.Controller.getWidgets().length).toEqual(1)

  it "allWidgetsExecute is removing the inactive widgets", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Weather.Controller.setupWidgetIn(container1, "123456")
    Weather.Controller.setupWidgetIn(container2, "123456")
    Weather.Controller.widgets[0].setAsInactive()
    Weather.Controller.allWidgetsExecute('hideForm')
    expect(Weather.Controller.widgets.length).toBe(1)

