namespace('Weather')

class Weather.API
  @getCurrentConditions: (zipcode, callback) ->
    url = @generateUrl(zipcode)
    $.get(url, (response) ->
      callback(response.current_observation)
      response
    , "jsonp")

  @generateUrl: (zipcode) ->
    "http://api.wunderground.com/api/#{@key}/conditions/q/#{zipcode}.json"
