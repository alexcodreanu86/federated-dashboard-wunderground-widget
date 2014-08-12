namespace('Weather.Widgets')

class Weather.Widgets.ResponseFormater
  @process: (weatherObj) ->
    formatedTime = Weather.Widgets.TimeFormater.process(weatherObj.local_time_rfc822)
    formatedResponse                    = {}
    formatedResponse.location           = weatherObj.display_location.full
    formatedResponse.weatherDescription = weatherObj.weather
    formatedResponse.temperature        = "#{weatherObj.temp_f}&deg;"
    formatedResponse.iconUrl            = weatherObj.icon_url
    formatedResponse.localTime          = formatedTime.time
    formatedResponse.amOrPm             = formatedTime.amOrPm
    formatedResponse
