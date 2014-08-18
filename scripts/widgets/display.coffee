namespace("Weather.Widget")

class Weather.Widgets.Display
  constructor: (container, animationSpeed) ->
    @container = container
    @animationSpeed = animationSpeed

  setupWidget: ->
    widgetHtml = Weather.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=weather-search]").val()

  showCurrentWeather: (weatherObj) ->
    formatedResponse = Weather.Widgets.ResponseFormater.process(weatherObj)
    weatherHtml = Weather.Widgets.Templates.renderCurrentConditions(formatedResponse)
    $("#{@container} [data-id=weather-output]").html(weatherHtml)

  exitEditMode: ->
    @hideForm()
    @hideCloseWidget()

  hideForm: ->
    $("#{@container} [data-id=weather-form]").hide(@animationSpeed)

  hideCloseWidget: ->
    $("#{@container} [data-id=weather-close]").hide(@animationSpeed)

  enterEditMode: ->
    @showForm()
    @showCloseWidget()

  showForm: ->
    $("#{@container} [data-id=weather-form]").show(@animationSpeed)

  showCloseWidget: ->
    $("#{@container} [data-id=weather-close]").show(@animationSpeed)

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
