(function() {
  var clickOn, inputInto, setSandbox, setupFixtures, weatherObj;

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

  setSandbox = function() {
    return setFixtures(sandbox());
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
    it("getCurrentWeather calls Weather.API.getCurrentConditions", function() {
      var spy;
      spy = spyOn(Weather.API, 'getCurrentConditions').and.returnValue({});
      Weather.Controller.getCurrentWeather('60714');
      return expect(spy).toHaveBeenCalledWith('60714', Weather.View.showWeather);
    });
    it("setupWidgetIn is setting up widget in the desired element", function() {
      var html;
      setSandbox();
      Weather.Controller.setupWidgetIn('#sandbox', "123456");
      html = $('#sandbox');
      expect(html).toContainElement('[name=weather-search]');
      expect(html).toContainElement('[data-id=weather-button]');
      return expect(html).toContainElement('[data-id=weather-output]');
    });
    it("setupWidgetIn is assinging the apiKey to a global variable", function() {
      setSandbox();
      Weather.Controller.setupWidgetIn('#sandbox', "123456");
      return expect(Weather.API.key).toEqual("123456");
    });
    return it("setupWidgetIn binds the controller to process searches", function() {
      spyOn(Weather.Controller, 'bind');
      Weather.Controller.setupWidgetIn('#sandbox');
      return expect(Weather.Controller.bind).toHaveBeenCalled();
    });
  });

}).call(this);
