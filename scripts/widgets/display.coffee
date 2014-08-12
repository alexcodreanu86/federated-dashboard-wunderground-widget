namespace("Weather.Widget")

class Weather.Widgets.Display
  constructor: (container, animationSpeed) ->
    @container = container

  setupWidget: ->
    widgetHtml = Weather.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=weather-search]").val()

  showCurrentWeather: (weatherObj) ->
    weatherHtml = Weather.Widgets.Templates.renderCurrentConditions(weatherObj)
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
