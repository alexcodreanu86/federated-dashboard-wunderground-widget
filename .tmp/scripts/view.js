(function() {
  namespace('Weather');

  Weather.View = (function() {
    function View() {}

    View.getInput = function() {
      return $('[name=weather-search]').val();
    };

    View.showWeather = function(weatherObj) {
      var weatherHTML;
      weatherHTML = Weather.Template.renderCurrentConditions(weatherObj);
      return $('[data-id=weather-output]').html(weatherHTML);
    };

    View.displayFormIn = function(selector) {
      var formHtml;
      formHtml = Weather.Template.renderForm();
      return $(selector).html(formHtml);
    };

    return View;

  })();

}).call(this);
