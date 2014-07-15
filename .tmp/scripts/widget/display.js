(function() {
  namespace("Weather.Widget");

  Weather.Widget.Display = (function() {
    function Display(container) {
      this.container = container;
    }

    Display.prototype.setupWidget = function() {
      var widgetHtml;
      widgetHtml = Weather.Templates.renderForm();
      return $(this.container).append(widgetHtml);
    };

    Display.prototype.getInput = function() {
      return $("" + this.container + " [name=weather-search]").val();
    };

    Display.prototype.showCurrentWeather = function(weatherObj) {
      var weatherHtml;
      weatherHtml = Weather.Templates.renderCurrentConditions(weatherObj);
      return $("" + this.container + " [data-id=weather-output]").html(weatherHtml);
    };

    Display.prototype.hideForm = function() {
      return $("" + this.container + " [data-id=weather-form]").hide();
    };

    Display.prototype.showForm = function() {
      return $("" + this.container + " [data-id=weather-form]").show();
    };

    return Display;

  })();

}).call(this);
