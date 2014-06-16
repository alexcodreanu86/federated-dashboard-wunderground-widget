namespace('Weather')

class Weather.View
  @getInput: ->
    $('[name=weather-search]').val()

  @showWeather: (weatherObj) ->
    weatherHTML = Weather.View.renderCurrentConditions(weatherObj)
    $('[data-id=weather-output]').html(weatherHTML)

  @renderCurrentConditions: (weatherObj) ->
    new EJS({url: './scripts/weatherTemplate.ejs'}).render(weatherObj)

  @displayFormIn: (selector) ->
    formHtml = @renderForm()
    $(selector).html(formHtml)

  @renderForm: ->
    new EJS({url: './scripts/formTemplate.ejs'}).render({})
