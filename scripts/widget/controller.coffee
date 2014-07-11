namespace('Weather.Widget')

class Weather.Widget.Controller
  constructor: (container) ->
    @container = container

  initialize: ->
    $(@container).append("</h1>REPLACE THIS WITH REAL CONTENT</h1>")

  getContainer: ->
    @container
