weatherObj = {  current_observation: {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                }
              }

setupFixtures = ->
  setFixtures """
                <input name="weather-search" type="text"><br>
                <button data-id="weather-button">Get current weather</button><br>
                <div data-id="weather-output"></div>
              """

inputInto = (name, value)->
  $("[name=#{name}]").val(value)

clickOn = (element) ->
  $(element).click()

setSandbox = ->
  setFixtures(sandbox())

describe "Weather.Controller", ->

  it "the weather is displayed when the button is clicked", ->
    setupFixtures()
    Weather.Controller.bind()

    spyOn(Weather.API, 'getCurrentConditions').and.returnValue(Weather.View.showWeather(weatherObj.current_observation))
    inputInto('weather-search', "60714")
    clickOn('[data-id=weather-button]')
    expect($('[data-id=weather-output]').html()).toContainText('Niles')

  it "getCurrentWeather calls Weather.API.getCurrentConditions", ->
    spy = spyOn(Weather.API, 'getCurrentConditions').and.returnValue({})
    Weather.Controller.getCurrentWeather('60714')
    expect(spy).toHaveBeenCalledWith('60714', Weather.View.showWeather)

  it "setupWidgetIn is setting up widget in the desired element", ->
    setSandbox()
    Weather.Controller.setupWidgetIn('#sandbox', "123456")
    html = $('#sandbox')
    expect(html).toContainElement('[name=weather-search]')
    expect(html).toContainElement('[data-id=weather-button]')
    expect(html).toContainElement('[data-id=weather-output]')

  it "setupWidgetIn is assinging the apiKey to a global variable", ->
    setSandbox()
    Weather.Controller.setupWidgetIn('#sandbox', "123456")
    expect(Weather.API.key).toEqual("123456")

  it "setupWidgetIn binds the controller to process searches", ->
    spyOn(Weather.Controller, 'bind')
    Weather.Controller.setupWidgetIn('#sandbox')
    expect(Weather.Controller.bind).toHaveBeenCalled()
