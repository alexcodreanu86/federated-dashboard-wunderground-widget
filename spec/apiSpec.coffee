weatherObj = {  current_observation: {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                }
              }

describe 'Weather.API', ->
  it "getCurrentConditions returns current conditions for the argument zipcode", ->
    spyOn($, 'get').and.returnValue(weatherObj)
    response = Weather.API.getCurrentConditions('60714')
    expect(response).toEqual(weatherObj)
