(function() {
  namespace('Weather');

  Weather.Controller = (function() {
    function Controller() {}

    Controller.bind = function() {
      return $('[data-id=weather-button]').click((function(_this) {
        return function() {
          return _this.getCurrentWeather(Weather.View.getInput());
        };
      })(this));
    };

    Controller.getCurrentWeather = function(zipcode) {
      return Weather.API.getCurrentConditions(zipcode, Weather.View.showWeather);
    };

    return Controller;

  })();

}).call(this);
