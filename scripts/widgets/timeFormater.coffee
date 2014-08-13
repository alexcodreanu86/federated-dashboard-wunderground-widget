namespace('Weather.Widgets')

class Weather.Widgets.TimeFormater
  @process: (dateString) ->
    dateObj = @getDateObjWithNoTimezone(dateString)
    hours = @getHours(dateObj)
    minutes = @getMinutes(dateObj)
    amOrPm = @getAmPm(dateObj)
    {time: "#{hours}:#{minutes}", amOrPm: amOrPm}

  @getDateObjWithNoTimezone: (dateString) ->
    date = dateString.substring(0, dateString.length - 6)
    new Date(date)


  @getMinutes: (dateObj) ->
    minutes = dateObj.getMinutes()
    if minutes < 10
      "0" + minutes
    else
      minutes

  @getHours: (dateObj) ->
    hours = dateObj.getHours()
    if hours > 12
      hours - 12
    else
      hours

  @getAmPm: (dateObj) ->
    hours = dateObj.getHours()
    if @isBeforeNoon(hours)
      "AM"
    else
      "PM"

  @isBeforeNoon: (hours) ->
    hours < 12
