namespace('Weather.Widgets')

class Weather.Widgets.API
  @getCurrentConditions: (requestData, displayer) ->
    url = @generateUrl(requestData)
    $.get(url, (response) ->
      displayer.showCurrentWeather(response.current_observation)
      response
    , "jsonp")

  @generateUrl: (data) ->
    "http://api.wunderground.com/api/#{data.key}/conditions/q/#{data.location}.json"
