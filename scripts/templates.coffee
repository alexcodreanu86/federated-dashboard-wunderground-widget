namespace('Weather')

class Weather.Template
  @renderForm: ->
    _.template("""
                  <input name="weather-search" type="text"><br>
                  <button id="weather" data-id="weather-button">Get current weather</button><br>
                  <div data-id="weather-output"></div>
                """)

  @renderCurrentConditions: (weatherObj) ->
    _.template( """
                  <p><%= display_location.full %> <%= temp_f %>&deg; F</p>
                  <p><%= weather %></p>
                  <p><img src='<%= icon_url %>'></p>
                """, weatherObj)
