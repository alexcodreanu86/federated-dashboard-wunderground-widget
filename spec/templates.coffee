weatherObj = {  current_observation: {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                }
              }

describe "Weather.Templates", ->
  it "renderCurrentConditions generates proper html string", ->
    str = Weather.Templates.renderCurrentConditions(weatherObj.current_observation)
    expect(str).toContainElement('img')
    expect(str).toContainText('Niles')
