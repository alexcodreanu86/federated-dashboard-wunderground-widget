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
                  <p><%= display_location.full %> <%= temp_f %>&deg; F</p>
                  <p><%= weather %></p>
                  <p><img src='<%= icon_url %>'></p>
                """, weatherObj)

