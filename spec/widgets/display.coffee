weatherObj = {
                display_location: {
                  full: "Niles IL"
                }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                local_time_rfc822: "Tue, 12 Aug 2014 19:50:23 -0500"
              }

setupOneContainer = ->
  setFixtures " <div data-id='widget-container-1'></div>"

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

newDisplay = (container) ->
  new Weather.Widgets.Display(container)

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

describe "Weather.Widget.Display", ->
  it "stores the container it is initialized with", ->
    display = newDisplay(container1)
    expect(display.container).toEqual(container1)

  it "setupWidget is setting up the widget in it's container", ->
    display = newDisplay(container1)
    setupOneContainer()
    display.setupWidget()
    expect(container1).toContainElement('.widget .widget-header')

  it "getInput returns the input in the field in it's own container", ->
    setupTwoContainers()
    display1 = newDisplay(container1)
    display2 = newDisplay(container2)
    display1.setupWidget()
    display2.setupWidget()
    $("#{container1} [name=widget-input]").val("text1")
    $("#{container2} [name=widget-input]").val("text2")
    expect(display1.getInput()).toEqual("text1")
    expect(display2.getInput()).toEqual("text2")

  it "showCurrentWeather is displaying the weather properly in its container", ->
    setupTwoContainers()
    display = newDisplay(container1)
    display2 = newDisplay(container2)
    display.setupWidget()
    display2.setupWidget()
    display.showCurrentWeather(weatherObj)
    expect($("#{container1} [data-name=widget-output]")).toContainText('Niles')
    expect($("#{container2} [data-name=widget-output]")).not.toContainText('Niles')

  it "removeWidget is removing the widget's content", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.removeWidget()
    expect($(container1)).not.toContainElement("[data-id=weather-widget-wrapper]")

  it "getDisplayedTime returns the current time on the screen", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.showCurrentWeather(weatherObj)
    expect(display.getDisplayedTime()).toEqual('7:50')

  it "incrementTime is incrementing the current time displayed", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.showCurrentWeather(weatherObj)
    expect(display.getDisplayedTime()).toEqual('7:50')
    display.incrementTime()
    expect(display.getDisplayedTime()).toEqual('7:51')
