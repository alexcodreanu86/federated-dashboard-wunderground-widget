namespace('Weather.Widgets')

class Weather.Widgets.Controller
  apiKey = undefined
  constructor: (settings) ->
    apiKey = settings.key
    @container = settings.container
    @display = new Weather.Widgets.Display(@container, settings.animationSpeed)
    @activeStatus = false
    @defaultValue = settings.defaultValue

  initialize: ->
    @display.setupWidget()
    @bind()
    @displayDefault()
    @setAsActive()

  displayDefault: ->
    if @defaultValue
      @displayCurrentConditions(@defaultValue)

  setAsActive: ->
    @activeStatus = true

  setAsInactive: ->
    @activeStatus = false

  isActive: ->
    @activeStatus

  bind: ->
    $("#{@container} [data-id=weather-button]").click(=> @processClickedButton())
    $("#{@container} [data-id=weather-close]").click(=> @closeWidget())

  processClickedButton: ->
    input = @display.getInput()
    @displayCurrentConditions(input)

  displayCurrentConditions: (input) ->
    requestData = {key: apiKey, location: input}
    Weather.Widgets.API.getCurrentConditions(requestData, @display)

  closeWidget: ->
    @unbind()
    @removeContent()
    @setAsInactive()

  removeContent: ->
    @display.removeWidget()

  unbind: ->
    $("#{@container} [data-id=weather-button]").unbind('click')
    $("#{@container} [data-id=weather-close]").unbind('click')

  hideForm: ->
    @display.exitEditMode()

  showForm: ->
    @display.enterEditMode()

  getContainer: ->
    @container
