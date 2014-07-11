(function() {
  namespace('Weather');

  Weather.Display = (function() {
    function Display() {}

    Display.getInput = function() {
      return $('[name=weather-search]').val();
    };

    Display.showWeather = function(weatherObj) {
      var weatherHTML;
      console.log(weatherObj);
      weatherHTML = Weather.Templates.renderCurrentConditions(weatherObj);
      return $('[data-id=weather-output]').html(weatherHTML);
    };

    Display.showFormIn = function(selector) {
      var formHtml;
      formHtml = Weather.Templates.renderForm();
      return $(selector).html(formHtml);
    };

    Display.logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-wunderground-widget/master/lib/icon_7747/weather_icon.png";

    Display.generateLogo = function(config) {
      var logoSrc;
      logoSrc = this.logoSrc;
      _.extend(config, {
        imgSrc: logoSrc
      });
      return Weather.Templates.renderLogo(config);
    };

    Display.hideForm = function() {
      return $('[data-id=weather-form]').hide();
    };

    Display.showForm = function() {
      return $('[data-id=weather-form]').show();
    };

    return Display;

  })();

}).call(this);
