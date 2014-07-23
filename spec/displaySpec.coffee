describe "Weather.Display", ->
  it "generateLogo returns the weather image tag", ->
    imageHtml = Weather.Display.generateLogo({dataId: "weather-logo"})
    expect(imageHtml).toBeMatchedBy('[data-id=weather-logo]')
