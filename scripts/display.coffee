namespace('Weather')

class Weather.Display
  @generateLogo: (config) ->
    "<i class=\"fa fa-umbrella #{config.class}\" data-id=\"#{config.dataId}\"></i>"
