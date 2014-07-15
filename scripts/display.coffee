namespace('Weather')

class Weather.Display
  @logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-wunderground-widget/master/lib/icon_7747/weather_icon.png"

  @generateLogo: (config) ->
    logoSrc = @logoSrc
    _.extend(config, {imgSrc: logoSrc})
    Weather.Templates.renderLogo(config)
