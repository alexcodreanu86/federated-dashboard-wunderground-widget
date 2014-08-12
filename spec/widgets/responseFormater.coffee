describe "Weather.Widgets.ResponseFormater", ->
  weatherObj = {
                  display_location: {
                    full: "Niles IL"
                  }, weather: "Partly Cloudy", temp_f: "77.9", icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                  local_time_rfc822: "Tue, 12 Aug 2014 19:50:23 -0500"
                }

  it "process returns properly formated response", ->
    formatedResponse = Weather.Widgets.ResponseFormater.process(weatherObj)
    expect(formatedResponse.location).toEqual("Niles IL")
    expect(formatedResponse.weatherDescription).toEqual("Partly Cloudy")
    expect(formatedResponse.temperature).toEqual("77.9&deg;")
    expect(formatedResponse.iconUrl).toEqual("http://icons.wxug.com/i/c/k/partlycloudy.gif")
    expect(formatedResponse.localTime).toEqual("7:50")
    expect(formatedResponse.amOrPm).toEqual("PM")


