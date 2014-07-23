namespace('Weather')

class Weather.Controller
  @widgets: []

  @setupWidgetIn: (container, apiKey, defaultValue) ->
    widget = new Weather.Widgets.Controller(container, apiKey, defaultValue)
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
    _.each(@widgets, (widget) =>
      if widget.isActive()
        widget[command]()
      else
        @removeFromWidgetsContainer(widget)
    )

  @closeWidgetInContainer: (container) ->
    widget = _.filter(@widgets, (widget, index) ->
      widget.container == container
    )[0]
    if widget
      @closeWidget(widget)
      @removeFromWidgetsContainer(widget)

  @removeFromWidgetsContainer: (widgetToRemove) ->
    @widgets = _.reject(@widgets, (widget) ->
      return widget == widgetToRemove
    )

  @closeWidget: (widget) ->
    widget.closeWidget()
