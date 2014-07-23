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

  hideForm: ->
    $("#{@container} [data-id=weather-form]").hide()

  showForm: ->
    $("#{@container} [data-id=weather-form]").show()

  removeWidget: ->
    $(@container).remove()
