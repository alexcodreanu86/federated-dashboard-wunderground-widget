(function() {
  namespace('Weather');

  Weather.API = (function() {
    function API() {}

    API.getCurrentConditions = function(requestData, displayer) {
      var url;
      url = this.generateUrl(requestData);
      return $.get(url, function(response) {
        displayer.showCurrentWeather(response.current_observation);
        return response;
      }, "jsonp");
    };

    API.generateUrl = function(data) {
      return "http://api.wunderground.com/api/" + data.key + "/conditions/q/" + data.zipcode + ".json";
    };

    return API;

  })();

}).call(this);
