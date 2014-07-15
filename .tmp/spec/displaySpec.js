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
    return it("generateLogo returns the weather image tag", function() {
      var imageHtml;
      imageHtml = Weather.Display.generateLogo({
        dataId: "weather-logo"
      });
      return expect(imageHtml).toBeMatchedBy('[data-id=weather-logo]');
    });
  });

}).call(this);
