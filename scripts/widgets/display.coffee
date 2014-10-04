namespace("Weather.Widget")

class Weather.Widgets.Display
  constructor: (container, animationSpeed) ->
    @container = container
    @animationSpeed = animationSpeed

  setupWidget: ->
    widgetHtml = Weather.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=widget-input]").val()

  showCurrentWeather: (weatherObj) ->
    formatedResponse = Weather.Widgets.ResponseFormater.process(weatherObj)
    weatherHtml = Weather.Widgets.Templates.renderCurrentConditions(formatedResponse)
    $("#{@container} [data-name=widget-output]").html(weatherHtml)

  removeWidget: ->
    $(@container).remove()

  getDisplayedTime: ->
    $("#{@container} [data-id=weather-time]").text()

  incrementTime: ->
    currentTime = @getDisplayedTime()
    minutesDigit = @getLastChar(currentTime)
    incrementedDigit = parseInt(minutesDigit) + 1
    incrementedTime = currentTime.replace(/\d$/, incrementedDigit)
    @setTime(incrementedTime)

  getLastChar: (str) ->
    str[str.length - 1]

  setTime: (time) ->
    $("#{@container} [data-id=weather-time]").text(time)
