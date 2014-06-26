namespace('Weather')

class Weather.Controller
  @bind: ->
    $('[data-id=weather-button]').click( => @getCurrentWeather(Weather.Display.getInput()))

  @getCurrentWeather: (zipcode) ->
    Weather.API.getCurrentConditions(zipcode, Weather.Display.showWeather)

  @setupWidgetIn: (container, apiKey) ->
    Weather.Display.showFormIn(container)
    Weather.API.key = apiKey
    @bind()
