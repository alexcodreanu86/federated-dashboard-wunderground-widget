namespace('Weather')

class Weather.View
  @getInput: ->
    $('[name=weather-search]').val()

  @showWeather: (weatherObj) ->
    weatherHTML = Weather.Template.renderCurrentConditions(weatherObj)
    $('[data-id=weather-output]').html(weatherHTML)

  @displayFormIn: (selector) ->
    formHtml = Weather.Template.renderForm()
    $(selector).html(formHtml)

