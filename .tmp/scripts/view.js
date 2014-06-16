(function() {
  namespace('Weather');

  Weather.View = (function() {
    function View() {}

    View.getInput = function() {
      return $('[name=weather-search]').val();
    };

    View.showWeather = function(weatherObj) {
      var weatherHTML;
      weatherHTML = Weather.View.renderCurrentConditions(weatherObj);
      return $('[data-id=weather-output]').html(weatherHTML);
    };

    View.renderCurrentConditions = function(weatherObj) {
      return new EJS({
        url: './bower_components/wunderground-widget/scripts/weatherTemplate.ejs'
      }).render(weatherObj);
    };

    View.displayFormIn = function(selector) {
      var formHtml;
      formHtml = this.renderForm();
      return $(selector).html(formHtml);
    };

    View.renderForm = function() {
      return new EJS({
        url: './bower_components/wunderground-widget/scripts/formTemplate.ejs'
      }).render({});
    };

    return View;

  })();

}).call(this);
