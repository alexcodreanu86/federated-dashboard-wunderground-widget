(function() {
  namespace('Weather');

  Weather.API = (function() {
    function API() {}

    API.getCurrentConditions = function(zipcode, callback) {
      return $.get("http://api.wunderground.com/api/12ba191e2fec98ad/conditions/q/" + zipcode + ".json", function(response) {
        callback(response.current_observation);
        return response;
      }, "jsonp");
    };

    return API;

  })();

}).call(this);
