(function() {
  var clickOn, inputInto, setupFixtures, weatherObj;

  weatherObj = {
    current_observation: {
      display_location: {
        full: "Niles IL"
      },
      weather: "Partly Cloudy",
      temp_f: "77.9",
      icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
    }
  };

  setupFixtures = function() {
    return setFixtures("<input name=\"weather-search\" type=\"text\"><br>\n<button data-id=\"weather-button\">Get current weather</button><br>\n<div data-id=\"weather-output\"></div>");
  };

  inputInto = function(name, value) {
    return $("[name=" + name + "]").val(value);
  };

  clickOn = function(element) {
    return $(element).click();
  };

  describe("Weather.Controller", function() {
    it("the weather is displayed when the button is clicked", function() {
      setupFixtures();
      Weather.Controller.bind();
      spyOn(Weather.API, 'getCurrentConditions').and.returnValue(Weather.View.showWeather(weatherObj.current_observation));
      inputInto('weather-search', "60714");
      clickOn('[data-id=weather-button]');
      return expect($('[data-id=weather-output]').html()).toContainText('Niles');
    });
    return it("getCurrentWeather calls Weather.API.getCurrentConditions", function() {
      var spy;
      spy = spyOn(Weather.API, 'getCurrentConditions').and.returnValue({});
      Weather.Controller.getCurrentWeather('60714');
      return expect(spy).toHaveBeenCalledWith('60714', Weather.View.showWeather);
    });
  });

}).call(this);
