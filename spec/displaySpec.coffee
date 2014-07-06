weatherObj = {  current_observation: {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                }
              }
inputInto = (name, value)->
  $("[name=#{name}]").val(value)

setSandbox = ->
  setFixtures(sandbox())


appendToSandbox = (html)->
  $('#sandbox').append(html)

describe "Weather.Display", ->
  it "getInput returns the input in the weather-search field", ->
    setFixtures '<input name="weather-search" type="text"><br>'
    inputInto('weather-search', '60714')
    expect(Weather.Display.getInput()).toEqual('60714')

  it "showWeather displays the current Weather", ->
    setFixtures "<div data-id='weather-output'></div>"
    Weather.Display.showWeather(weatherObj.current_observation)
    html = $("[data-id=weather-output]")
    expect(html).toContainText("Niles IL 77.9° F")


  it "showFormIn appends the weather form to the given container", ->
    setSandbox()
    Weather.Display.showFormIn('#sandbox')
    html = $('#sandbox')
    expect(html).toContainElement('[name=weather-search]')
    expect(html).toContainElement('[data-id=weather-button]')
    expect(html).toContainElement('[data-id=weather-output]')

  it "generateLogo returns the weather image tag", ->
    imageHtml = Weather.Display.generateLogo({dataId: "weather-logo"})
    expect(imageHtml).toBeMatchedBy('[data-id=weather-logo]')

  it "hideForm hides the form", ->
    setSandbox()
    Weather.Controller.setupWidgetIn('#sandbox')
    expect($('#sandbox')).toContainElement('[name=weather-search]')
    Weather.Display.hideForm()
    expect($('[data-id=weather-form]').attr('style')).toEqual('display: none;')

  it "showForm displays the form", ->
    setSandbox()
    Weather.Controller.setupWidgetIn('#sandbox')
    Weather.Display.hideForm()
    Weather.Display.showForm()
    expect($('[data-id=weather-form]').attr('style')).not.toEqual('display: none;')
