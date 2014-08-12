namespace('Weather.Widgets')

class Weather.Widgets.TimeFormater
  @process: (timeString) ->
    timeObj = new Date(timeString)
    minutes = timeObj.getMinutes()
    hours = timeObj.getHours()
    if @isBeforeNoon(hours)
      amOrPm = "AM"
    else
      amOrPm = "PM"
      hours -= 12
    {time: "#{hours}:#{minutes}", amOrPm: amOrPm}

  @isBeforeNoon: (hours) ->
    hours < 12
