(function() {
  var firstArgumentOfFirstCall, weatherObj;

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

  firstArgumentOfFirstCall = function(spy) {
    return spy.calls.argsFor(0)[0];
  };

  describe('Weather.API', function() {
    it("getCurrentConditions returns current conditions for the argument zipcode", function() {
      var data, response, spy;
      spy = spyOn($, 'get').and.returnValue(weatherObj);
      data = {
        key: '123456',
        zipcode: '60714'
      };
      response = Weather.API.getCurrentConditions(data);
      expect(response).toEqual(weatherObj);
      return expect(firstArgumentOfFirstCall(spy)).toEqual("http://api.wunderground.com/api/123456/conditions/q/60714.json");
    });
    return it("generateUrl returns a properly formated url", function() {
      var data, url;
      data = {
        key: '123456',
        zipcode: '60714'
      };
      url = Weather.API.generateUrl(data);
      return expect(url).toEqual("http://api.wunderground.com/api/123456/conditions/q/60714.json");
    });
  });

}).call(this);
