namespace("Weather.Widget")

class Weather.Widgets.Display
  constructor: (container) ->
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
    $("#{@container} [data-id=weather-form]").hide()

  hideCloseWidget: ->
    $("#{@container} [data-id=weather-close]").hide()

  enterEditMode: ->
    @showForm()
    @showCloseWidget()

  showForm: ->
    $("#{@container} [data-id=weather-form]").show()

  showCloseWidget: ->
    $("#{@container} [data-id=weather-close]").show()

  removeWidget: ->
    $(@container).remove()
