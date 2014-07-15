namespace('Weather')

class Weather.Controller
  @widgets: []

  @setupWidgetIn: (container, apiKey) ->
    widget = new Weather.Widget.Controller(container, apiKey)
    widget.initialize()
    @addToWidgetsContainer(widget)

  @addToWidgetsContainer: (widget) ->
    @widgets.push(widget)

  @getWidgets: ->
    @widgets

  @hideForms: ->
    @allWidgetsExecute("hideForm")

  @showForms: ->
    @allWidgetsExecute("showForm")

  @allWidgetsExecute: (command) ->
    _.each(@widgets, (widget) ->
      widget[command]()
    )

