namespace('Weather')

class Weather.Display
  @getInput: ->
    $('[name=weather-search]').val()

  @showWeather: (weatherObj) ->
    weatherHTML = Weather.Templates.renderCurrentConditions(weatherObj)
    $('[data-id=weather-output]').html(weatherHTML)

  @showFormIn: (selector) ->
    formHtml = Weather.Templates.renderForm()
    $(selector).html(formHtml)

  @logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-wunderground-widget/master/lib/icon_7747/weather_icon.png"

  @generateLogo: (config) ->
    logoSrc = @logoSrc
    _.extend(config, {imgSrc: logoSrc})
    Weather.Templates.renderLogo(config)
