namespace('Weather')

class Weather.View
  @getInput: ->
    $('[name=weather-search]').val()

  @showWeather: (weatherObj) ->
    weatherHTML = Weather.View.generateHtml(weatherObj)
    $('[data-id=weather-output]').html(weatherHTML)

  @generateHtml: (weatherObj) ->
    new EJS({url: 'scripts/frontEnd/weather/template.ejs'}).render(weatherObj)
