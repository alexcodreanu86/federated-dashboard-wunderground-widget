(function() {
  var inputInto, weatherObj;

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

  describe("Weather.View", function() {
    it("getInput returns the input in the weather-search field", function() {
      setFixtures('<input name="weather-search" type="text"><br>');
      inputInto('weather-search', '60714');
      return expect(Weather.View.getInput()).toEqual('60714');
    });
    it("showWeather displays the current Weather", function() {
      var html;
      setFixtures("<div data-id='weather-output'></div>");
      Weather.View.showWeather(weatherObj.current_observation);
      html = $("[data-id=weather-output]");
      return expect(html).toContainText("Niles IL 77.9° F");
    });
    return it("generateHtml generates proper html string", function() {
      var str;
      str = Weather.View.generateHtml(weatherObj.current_observation);
      expect(str).toContainElement('img');
      return expect(str).toContainText('Niles');
    });
  });

}).call(this);
