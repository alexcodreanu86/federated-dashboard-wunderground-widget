(function() {
  var appendToSandbox, inputInto, setSandbox, weatherObj;

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

  inputInto = function(name, value) {
    return $("[name=" + name + "]").val(value);
  };

  setSandbox = function() {
    return setFixtures(sandbox());
  };

  appendToSandbox = function(html) {
    return $('#sandbox').append(html);
  };

  describe("Weather.Display", function() {
    it("getInput returns the input in the weather-search field", function() {
      setFixtures('<input name="weather-search" type="text"><br>');
      inputInto('weather-search', '60714');
      return expect(Weather.Display.getInput()).toEqual('60714');
    });
    it("showWeather displays the current Weather", function() {
      var html;
      setFixtures("<div data-id='weather-output'></div>");
      Weather.Display.showWeather(weatherObj.current_observation);
      html = $("[data-id=weather-output]");
      return expect(html).toContainText("Niles IL 77.9° F");
    });
    it("showFormIn appends the weather form to the given container", function() {
      var html;
      setSandbox();
      Weather.Display.showFormIn('#sandbox');
      html = $('#sandbox');
      expect(html).toContainElement('[name=weather-search]');
      expect(html).toContainElement('[data-id=weather-button]');
      return expect(html).toContainElement('[data-id=weather-output]');
    });
    return it("generateLogo returns the weather image tag", function() {
      var imageHtml;
      imageHtml = Weather.Display.generateLogo({
        dataId: "weather-logo"
      });
      return expect(imageHtml).toBeMatchedBy('[data-id=weather-logo]');
    });
  });

}).call(this);
