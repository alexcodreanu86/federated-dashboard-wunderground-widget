namespace('Weather')

class Weather.API
  @getCurrentConditions: (requestData, displayer) ->
    url = @generateUrl(requestData)
    $.get(url, (response) ->
      displayer.showCurrentWeather(response.current_observation)
      response
    , "jsonp")

  @generateUrl: (data) ->
    "http://api.wunderground.com/api/#{data.key}/conditions/q/#{data.zipcode}.json"
