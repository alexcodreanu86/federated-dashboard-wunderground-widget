namespace('Weather')

class Weather.Controller
  @setupWidgetIn: (settings) ->
    new Weather.Widgets.Controller(settings).initialize()
