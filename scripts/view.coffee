namespace('Weather')

class Weather.View
  @getInput: ->
    $('[name=weather-search]').val()

  @showWeather: (weatherObj) ->
    weatherHTML = Weather.Templates.renderCurrentConditions(weatherObj)
    $('[data-id=weather-output]').html(weatherHTML)

  @displayFormIn: (selector) ->
    formHtml = Weather.Templates.renderForm()
    $(selector).html(formHtml)
