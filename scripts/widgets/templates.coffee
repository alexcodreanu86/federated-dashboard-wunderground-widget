namespace("Weather.Widgets")

class Weather.Widgets.Templates
  @renderForm: (widgetData) ->
    _.template("""
                  <div class='widget' data-name='widget-wrapper'>
                    <div class='widget-header' data-name='sortable-handle'>
                      <h2 class="widget-title">Weather</h2>
                      <span class='widget-close' data-name='widget-close'>×</span>
                      <form class='widget-form' data-name='widget-form'>
                        <input name='widget-input' type='text' autofocus='true'>
                        <button data-name="form-button">Get current weather</button><br>
                      </form>
                    </div>
                    <div class="widget-body" data-name="widget-output"></div>
                  </div>
                """, {})

  @renderCurrentConditions: (weatherObj) ->
    _.template( """
                  <div class="weather-location-container">
                    <p class="weather-location"><%= location %> </p>
                    <p class="weather-local-time">
                      <span class="weather-time" data-id="weather-time"><%= localTime %></span>
                      <span class="weather-am-pm"><%= amOrPm %></span>
                    </p>
                  </div>
                  <div class="weather-information-container">
                    <img class="weather-description-icon" src='<%= iconUrl %>'>
                    <p class="weather-temperature"><%= temperature %></p>
                  </div>
                """, weatherObj)

