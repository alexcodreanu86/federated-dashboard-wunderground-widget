(function() {
  namespace('Weather');

  Weather.API = (function() {
    function API() {}

    API.getCurrentConditions = function(zipcode, callback) {
      var url;
      url = this.generateUrl(zipcode);
      return $.get(url, function(response) {
        callback(response.current_observation);
        return response;
      }, "jsonp");
    };

    API.generateUrl = function(zipcode) {
      return "http://api.wunderground.com/api/" + this.key + "/conditions/q/" + zipcode + ".json";
    };

    return API;

  })();

}).call(this);
