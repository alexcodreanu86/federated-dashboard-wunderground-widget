describe "Weather.Widgets.TimeFormater", ->
  it "returns proper time for a date with AM time", ->
    amDate = "Tue, 12 Aug 2014 11:47:23 -0500"
    formatedDate = Weather.Widgets.TimeFormater.process(amDate)
    expect(formatedDate.time).toEqual("11:47")
    expect(formatedDate.amOrPm).toEqual("AM")

  it "returns proper time for a date with PM time", ->
    pmDate = "Tue, 12 Aug 2014 17:50:23 -0500"
    formatedDate = Weather.Widgets.TimeFormater.process(pmDate)
    expect(formatedDate.time).toEqual("5:50")
    expect(formatedDate.amOrPm).toEqual("PM")
