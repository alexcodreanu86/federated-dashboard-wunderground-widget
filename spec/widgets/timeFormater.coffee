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

  it "returns proper time for a date with minutes less than 10", ->
    pmDate = "Tue, 12 Aug 2014 17:05:23 -0500"
    formatedDate = Weather.Widgets.TimeFormater.process(pmDate)
    expect(formatedDate.time).toEqual("5:05")
    expect(formatedDate.amOrPm).toEqual("PM")

  it "returns proper time for noon time", ->
    pmDate = "Tue, 12 Aug 2014 12:05:23 +0100"
    formatedDate = Weather.Widgets.TimeFormater.process(pmDate)
    expect(formatedDate.time).toEqual("12:05")
    expect(formatedDate.amOrPm).toEqual("PM")
