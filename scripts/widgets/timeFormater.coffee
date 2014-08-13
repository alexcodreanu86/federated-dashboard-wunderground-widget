namespace('Weather.Widgets')

class Weather.Widgets.TimeFormater
  @process: (dateString) ->
    dateObj = new Date(dateString)
    minutes = @getMinutes(dateObj)
    hours = dateObj.getHours()
    if @isBeforeNoon(hours)
      amOrPm = "AM"
    else
      amOrPm = "PM"
      hours -= 12
    {time: "#{hours}:#{minutes}", amOrPm: amOrPm}

  @isBeforeNoon: (hours) ->
    hours < 12

  @getMinutes: (dateObj) ->
    minutes = dateObj.getMinutes()
    if minutes < 10
      "0" + minutes
    else
      minutes
