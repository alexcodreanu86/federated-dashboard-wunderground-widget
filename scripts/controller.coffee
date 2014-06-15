namespace('Weather')

class Weather.Controller
  @bind: ->
    $('[data-id=weather-button]').click( => @getCurrentWeather(Weather.View.getInput()))

  @getCurrentWeather: (zipcode) ->
    Weather.API.getCurrentConditions(zipcode, Weather.View.showWeather)

