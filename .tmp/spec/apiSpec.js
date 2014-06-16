(function() {
  var weatherObj;

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

  describe('Weather.API', function() {
    it("getCurrentConditions returns current conditions for the argument zipcode", function() {
      var response;
      spyOn($, 'get').and.returnValue(weatherObj);
      response = Weather.API.getCurrentConditions('60714');
      return expect(response).toEqual(weatherObj);
    });
    return it("generateUrl returns a properly formated url", function() {
      var url;
      window.apiKey = '123456';
      url = Weather.API.generateUrl('60714');
      return expect(url).toEqual("http://api.wunderground.com/api/123456/conditions/q/60714.json");
    });
  });

}).call(this);
