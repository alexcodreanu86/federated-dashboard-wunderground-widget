weatherObj = {  current_observation: {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                }
              }
inputInto = (name, value)->
  $("[name=#{name}]").val(value)

describe "Weather.View", ->
  it "getInput returns the input in the weather-search field", ->
    setFixtures '<input name="weather-search" type="text"><br>'
    inputInto('weather-search', '60714')
    expect(Weather.View.getInput()).toEqual('60714')

  it "showWeather displays the current Weather", ->
    setFixtures "<div data-id='weather-output'></div>"
    Weather.View.showWeather(weatherObj.current_observation)
    html = $("[data-id=weather-output]")
    expect(html).toContainText("Niles IL 77.9° F")

  it "generateHtml generates proper html string", ->
    str = Weather.View.generateHtml(weatherObj.current_observation)
    expect(str).toContainElement('img')
    expect(str).toContainText('Niles')
