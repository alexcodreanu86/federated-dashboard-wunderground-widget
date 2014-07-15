namespace('Weather.Widget')

class Weather.Widget.Controller
  apiKey = undefined
  constructor: (container, key) ->
    apiKey = key
    @container = container
    @display = new Weather.Widget.Display(container)

  initialize: ->
    @display.setupWidget()
    @bind()

  getContainer: ->
    @container

  bind: ->
    $("#{@container} [data-id=weather-button]").click(=> @processClickedButton())

  processClickedButton: ->
    input = @display.getInput()
    requestData = {key: apiKey, zipcode: input}
    Weather.API.getCurrentConditions(requestData, @display)

  hideForm: ->
    @display.hideForm()

  showForm: ->
    @display.showForm()

  removeContent: ->
    @display.removeWidget()
