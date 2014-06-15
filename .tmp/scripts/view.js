(function() {
  namespace('Weather');

  Weather.View = (function() {
    function View() {}

    View.getInput = function() {
      return $('[name=weather-search]').val();
    };

    View.showWeather = function(weatherObj) {
      var weatherHTML;
      weatherHTML = Weather.View.generateHtml(weatherObj);
      return $('[data-id=weather-output]').html(weatherHTML);
    };

    View.generateHtml = function(weatherObj) {
      return new EJS({
        url: 'scripts/weatherTemplate.ejs'
      }).render(weatherObj);
    };

    return View;

  })();

}).call(this);
