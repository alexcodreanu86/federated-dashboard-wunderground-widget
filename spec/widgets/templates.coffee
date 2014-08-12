weatherObj = {
                location: "Niles IL",
                weatherDescription: "Partly Cloudy",
                temperature: "77.9&deg;",
                iconUrl: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
                localTime: "7:50"
                amOrPm: "PM"
             }

describe "Weather.Templates.Templates", ->
  it "renderCurrentConditions generates proper html string", ->
    generatedHtml = Weather.Widgets.Templates.renderCurrentConditions(weatherObj)
    setFixtures sandbox()
    $('#sandbox').append(generatedHtml)
    expect($('#sandbox')).toContainElement('img')
    expect($('#sandbox')).toContainText('Niles')
    expect($('#sandbox')).toContainText('Partly Cloudy')
    expect($('#sandbox')).toContainText('7:50')
    expect($('#sandbox')).toContainText('PM')
