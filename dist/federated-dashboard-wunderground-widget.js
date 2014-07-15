(function(underscore) {
  'use strict';

  window.namespace = function(string, obj) {
    var current = window,
        names = string.split('.'),
        name;

    while((name = names.shift())) {
      current[name] = current[name] || {};
      current = current[name];
    }

    underscore.extend(current, obj);

  };

}(window._));

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

(function() {
  namespace('Weather');

  Weather.Controller = (function() {
    function Controller() {}

    Controller.widgets = [];

    Controller.setupWidgetIn = function(container, apiKey) {
      var widget;
      widget = new Weather.Widget.Controller(container, apiKey);
      widget.initialize();
      return this.addToWidgetsContainer(widget);
    };

    Controller.addToWidgetsContainer = function(widget) {
      return this.widgets.push(widget);
    };

    Controller.getWidgets = function() {
      return this.widgets;
    };

    Controller.hideForms = function() {
      return this.allWidgetsExecute("hideForm");
    };

    Controller.showForms = function() {
      return this.allWidgetsExecute("showForm");
    };

    Controller.allWidgetsExecute = function(command) {
      return _.each(this.widgets, function(widget) {
        return widget[command]();
      });
    };

    Controller.closeWidgetInContainer = function(container) {
      var widget;
      widget = _.filter(this.widgets, function(widget, index) {
        return widget.container === container;
      })[0];
      if (widget) {
        this.removeWidgetContent(widget);
        return this.removeFromWidgetsContainer(widget);
      }
    };

    Controller.removeFromWidgetsContainer = function(widgetToRemove) {
      return this.widgets = _.reject(this.widgets, function(widget) {
        return widget === widgetToRemove;
      });
    };

    Controller.removeWidgetContent = function(widget) {
      return widget.removeContent();
    };

    return Controller;

  })();

}).call(this);

(function() {
  namespace('Weather');

  Weather.Display = (function() {
    function Display() {}

    Display.logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-wunderground-widget/master/lib/icon_7747/weather_icon.png";

    Display.generateLogo = function(config) {
      var logoSrc;
      logoSrc = this.logoSrc;
      _.extend(config, {
        imgSrc: logoSrc
      });
      return Weather.Templates.renderLogo(config);
    };

    return Display;

  })();

}).call(this);

(function() {
  namespace('Weather');

  Weather.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function(widgetData) {
      return _.template("<div class=\"widget\" data-id=\"weather-widget-wrapper\">\n  <div class=\"widget-header\">\n    <h2 class=\"widget-title\">Weather</h2>\n    <div class=\"widget-form\" data-id=\"weather-form\">\n      <input name=\"weather-search\" type=\"text\" autofocus=\"true\">\n      <button id=\"weather\" data-id=\"weather-button\">Get current weather</button><br>\n    </div>\n  </div>\n  <div class=\"widget-body\" data-id=\"weather-output\"></div>\n</div>");
    };

    Templates.renderCurrentConditions = function(weatherObj) {
      return _.template("<p><%= display_location.full %> <%= temp_f %>&deg; F</p>\n<p><%= weather %></p>\n<p><img src='<%= icon_url %>'></p>", weatherObj);
    };

    Templates.renderLogo = function(imgData) {
      return _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {
        imgData: imgData
      });
    };

    return Templates;

  })();

}).call(this);

(function() {
  namespace('Weather.Widget');

  Weather.Widget.Controller = (function() {
    var apiKey;

    apiKey = void 0;

    function Controller(container, key) {
      apiKey = key;
      this.container = container;
      this.display = new Weather.Widget.Display(container);
    }

    Controller.prototype.initialize = function() {
      this.display.setupWidget();
      return this.bind();
    };

    Controller.prototype.getContainer = function() {
      return this.container;
    };

    Controller.prototype.bind = function() {
      return $("" + this.container + " [data-id=weather-button]").click((function(_this) {
        return function() {
          return _this.processClickedButton();
        };
      })(this));
    };

    Controller.prototype.processClickedButton = function() {
      var input, requestData;
      input = this.display.getInput();
      requestData = {
        key: apiKey,
        zipcode: input
      };
      return Weather.API.getCurrentConditions(requestData, this.display);
    };

    Controller.prototype.hideForm = function() {
      return this.display.hideForm();
    };

    Controller.prototype.showForm = function() {
      return this.display.showForm();
    };

    Controller.prototype.removeContent = function() {
      return this.display.removeWidget();
    };

    return Controller;

  })();

}).call(this);

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

    Display.prototype.removeWidget = function() {
      return $("" + this.container + " [data-id=weather-widget-wrapper]").remove();
    };

    return Display;

  })();

}).call(this);

(function() {


}).call(this);
