namespace("Weather.Widget")

class Weather.Widget.Display
  constructor: (container) ->
    @container = container

  setupWidget: ->
    widgetHtml = Weather.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=weather-search]").val()

  showCurrentWeather: (weatherObj) ->
    weatherHtml = Weather.Templates.renderCurrentConditions(weatherObj)
    $("#{@container} [data-id=weather-output]").html(weatherHtml)

  hideForm: ->
    $("#{@container} [data-id=weather-form]").hide()

  showForm: ->
    $("#{@container} [data-id=weather-form]").show()

  removeWidget: ->
    $("#{@container} [data-id=weather-widget-wrapper]").remove()
