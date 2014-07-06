namespace('Weather')

class Weather.Templates
  @renderForm: ->
    _.template("""
                  <div data-id=weather-widget-wrapper>
                    <div data-id="weather-form">
                      <input name="weather-search" type="text" autofocus="true">
                      <button id="weather" data-id="weather-button">Get current weather</button><br>
                    </div>
                  </div>
                  <div data-id="weather-output"></div>
                """)

  @renderCurrentConditions: (weatherObj) ->
    _.template( """
                  <p><%= display_location.full %> <%= temp_f %>&deg; F</p>
                  <p><%= weather %></p>
                  <p><img src='<%= icon_url %>'></p>
                """, weatherObj)

   @renderLogo: (imgData) ->
     _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {imgData: imgData})
