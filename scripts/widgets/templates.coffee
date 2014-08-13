namespace("Weather.Widgets")

class Weather.Widgets.Templates
  @renderForm: (widgetData) ->
    _.template("""
                  <div class="widget" data-id="weather-widget-wrapper">
                    <div class="widget-header">
                      <h2 class="widget-title">Weather</h2>
                      <span class='widget-close' data-id='weather-close'>×</span>
                      <div class="widget-form" data-id="weather-form">
                        <input name="weather-search" type="text" autofocus="true">
                        <button id="weather" data-id="weather-button">Get current weather</button><br>
                      </div>
                    </div>
                    <div class="widget-body" data-id="weather-output"></div>
                  </div>
                """)

  @renderCurrentConditions: (weatherObj) ->
    _.template( """
                  <div class="weather-location-container">
                    <p class="weather-location"><%= location %> </p>
                    <p class="weather-local-time">
                      <span class="weather-time"><%= localTime %></span>
                      <span class="weather-am-pm"><%= amOrPm %></span>
                    </p>
                  </div>
                  <div class="weather-information-container">
                    <img class="weather-description-icon" src='<%= iconUrl %>'>
                    <p class="weather-temperature"><%= temperature %></p>
                  </div>
                """, weatherObj)

