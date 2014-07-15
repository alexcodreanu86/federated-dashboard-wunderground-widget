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
  it "generateLogo returns the weather image tag", ->
    imageHtml = Weather.Display.generateLogo({dataId: "weather-logo"})
    expect(imageHtml).toBeMatchedBy('[data-id=weather-logo]')
