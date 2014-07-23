weatherObj = {  current_observation: {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                }
              }

data = {key: '123456', location: '60714'}

firstArgumentOfFirstCall = (spy) ->
  spy.calls.argsFor(0)[0]

describe 'Weather.Widgets.API', ->
  it "getCurrentConditions returns current conditions for the argument zipcode", ->
    spy = spyOn($, 'get').and.returnValue(weatherObj)
    response = Weather.Widgets.API.getCurrentConditions(data)
    expect(response).toEqual(weatherObj)
    expect(firstArgumentOfFirstCall(spy)).toEqual("http://api.wunderground.com/api/123456/conditions/q/60714.json")

  it "generateUrl returns a properly formated url", ->
    url = Weather.Widgets.API.generateUrl(data)
    expect(url).toEqual("http://api.wunderground.com/api/123456/conditions/q/60714.json")
