namespace('Weather')

class Weather.Controller
  @bind: ->
    $('[data-id=weather-button]').click( => @getCurrentWeather(Weather.View.getInput()))

  @getCurrentWeather: (zipcode) ->
    Weather.API.getCurrentConditions(zipcode, Weather.View.showWeather)

  @setupWidgetIn: (container, apiKey) ->
    Weather.View.displayFormIn(container)
    Weather.API.key = apiKey
    @bind()
