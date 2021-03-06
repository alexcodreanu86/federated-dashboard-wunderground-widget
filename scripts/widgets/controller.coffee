namespace('Weather.Widgets')

class Weather.Widgets.Controller
  apiKey = undefined
  constructor: (settings) ->
    apiKey = settings.key
    @container = settings.container
    @display = new Weather.Widgets.Display(@container, settings.animationSpeed)
    @refresh = settings.refresh
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
    @input = @display.getInput()
    @displayCurrentConditions(@input)

  displayCurrentConditions: (input) ->
    requestData = {key: apiKey, location: input}
    Weather.Widgets.API.getCurrentConditions(requestData, @display)
    if @refresh
      @initializeRefresh(input)

  initializeRefresh: (input) ->
    @clearActiveTimeout()
    @processRefresh(input)

  clearActiveTimeout: ->
    if @timeout
      clearTimeout(@timeout)

  processRefresh: (input) ->
    @timeout = setTimeout( =>
      if @isActive()
        @refreshCurrentConditions(input)
    , @nextRefresh())

  refreshCurrentConditions: (input) ->
    displayedTime = @display.getDisplayedTime()
    if @isTimeToRefresh(displayedTime)
      @displayCurrentConditions(input)
    else
      @initializeRefresh(input)
      @display.incrementTime()

  isTimeToRefresh: (displayedTime) ->
    minuteDigit = @display.getLastChar(displayedTime)
    parseInt(minuteDigit) == 9

  nextRefresh: ->
    time = new Date()
    (60 - time.getSeconds()) * 1000

  closeWidget: ->
    @unbind()
    @removeContent()
    @setAsInactive()

  removeContent: ->
    @display.removeWidget()

  unbind: ->
    $("#{@container} [data-id=weather-button]").unbind('click')
    $("#{@container} [data-id=weather-close]").unbind('click')

  exitEditMode: ->
    @display.exitEditMode()

  enterEditMode: ->
    @display.enterEditMode()

  getContainer: ->
    @container
