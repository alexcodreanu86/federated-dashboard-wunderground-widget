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

    Controller.setupWidgetIn = function(settings) {
      var widget;
      widget = new Weather.Widgets.Controller(settings);
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
      return _.each(this.widgets, (function(_this) {
        return function(widget) {
          if (widget.isActive()) {
            return widget[command]();
          } else {
            return _this.removeFromWidgetsContainer(widget);
          }
        };
      })(this));
    };

    Controller.closeWidgetInContainer = function(container) {
      var widget;
      widget = _.filter(this.widgets, function(widget, index) {
        return widget.container === container;
      })[0];
      if (widget) {
        this.closeWidget(widget);
        return this.removeFromWidgetsContainer(widget);
      }
    };

    Controller.removeFromWidgetsContainer = function(widgetToRemove) {
      return this.widgets = _.reject(this.widgets, function(widget) {
        return widget === widgetToRemove;
      });
    };

    Controller.closeWidget = function(widget) {
      return widget.closeWidget();
    };

    return Controller;

  })();

}).call(this);

(function() {
  namespace('Weather');

  Weather.Display = (function() {
    function Display() {}

    Display.generateLogo = function(config) {
      return "<i class=\"fa fa-umbrella " + config["class"] + "\" data-id=\"" + config.dataId + "\"></i>";
    };

    return Display;

  })();

}).call(this);

(function() {
  namespace('Weather');

  Weather.Templates = (function() {
    function Templates() {}

    Templates.renderLogo = function(imgData) {
      return _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {
        imgData: imgData
      });
    };

    return Templates;

  })();

}).call(this);

(function() {
  namespace('Weather.Widgets');

  Weather.Widgets.API = (function() {
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
      return "http://api.wunderground.com/api/" + data.key + "/conditions/q/" + data.location + ".json";
    };

    return API;

  })();

}).call(this);

(function() {
  namespace('Weather.Widgets');

  Weather.Widgets.Controller = (function() {
    var apiKey;

    apiKey = void 0;

    function Controller(settings) {
      apiKey = settings.key;
      this.container = settings.container;
      this.display = new Weather.Widgets.Display(this.container, settings.animationSpeed);
      this.activeStatus = false;
      this.defaultValue = settings.defaultValue;
    }

    Controller.prototype.initialize = function() {
      this.display.setupWidget();
      this.bind();
      this.displayDefault();
      return this.setAsActive();
    };

    Controller.prototype.displayDefault = function() {
      if (this.defaultValue) {
        return this.displayCurrentConditions(this.defaultValue);
      }
    };

    Controller.prototype.setAsActive = function() {
      return this.activeStatus = true;
    };

    Controller.prototype.setAsInactive = function() {
      return this.activeStatus = false;
    };

    Controller.prototype.isActive = function() {
      return this.activeStatus;
    };

    Controller.prototype.bind = function() {
      $("" + this.container + " [data-id=weather-button]").click((function(_this) {
        return function() {
          return _this.processClickedButton();
        };
      })(this));
      return $("" + this.container + " [data-id=weather-close]").click((function(_this) {
        return function() {
          return _this.closeWidget();
        };
      })(this));
    };

    Controller.prototype.processClickedButton = function() {
      var input;
      input = this.display.getInput();
      return this.displayCurrentConditions(input);
    };

    Controller.prototype.displayCurrentConditions = function(input) {
      var requestData;
      requestData = {
        key: apiKey,
        location: input
      };
      return Weather.Widgets.API.getCurrentConditions(requestData, this.display);
    };

    Controller.prototype.closeWidget = function() {
      this.unbind();
      this.removeContent();
      return this.setAsInactive();
    };

    Controller.prototype.removeContent = function() {
      return this.display.removeWidget();
    };

    Controller.prototype.unbind = function() {
      $("" + this.container + " [data-id=weather-button]").unbind('click');
      return $("" + this.container + " [data-id=weather-close]").unbind('click');
    };

    Controller.prototype.hideForm = function() {
      return this.display.exitEditMode();
    };

    Controller.prototype.showForm = function() {
      return this.display.enterEditMode();
    };

    Controller.prototype.getContainer = function() {
      return this.container;
    };

    return Controller;

  })();

}).call(this);

(function() {
  namespace("Weather.Widget");

  Weather.Widgets.Display = (function() {
    function Display(container, animationSpeed) {
      this.container = container;
      this.animationSpeed = animationSpeed;
    }

    Display.prototype.setupWidget = function() {
      var widgetHtml;
      widgetHtml = Weather.Widgets.Templates.renderForm();
      return $(this.container).append(widgetHtml);
    };

    Display.prototype.getInput = function() {
      return $("" + this.container + " [name=weather-search]").val();
    };

    Display.prototype.showCurrentWeather = function(weatherObj) {
      var weatherHtml;
      weatherHtml = Weather.Widgets.Templates.renderCurrentConditions(weatherObj);
      return $("" + this.container + " [data-id=weather-output]").html(weatherHtml);
    };

    Display.prototype.exitEditMode = function() {
      this.hideForm();
      return this.hideCloseWidget();
    };

    Display.prototype.hideForm = function() {
      return $("" + this.container + " [data-id=weather-form]").hide(this.animationSpeed);
    };

    Display.prototype.hideCloseWidget = function() {
      return $("" + this.container + " [data-id=weather-close]").hide(this.animationSpeed);
    };

    Display.prototype.enterEditMode = function() {
      this.showForm();
      return this.showCloseWidget();
    };

    Display.prototype.showForm = function() {
      return $("" + this.container + " [data-id=weather-form]").show(this.animationSpeed);
    };

    Display.prototype.showCloseWidget = function() {
      return $("" + this.container + " [data-id=weather-close]").show(this.animationSpeed);
    };

    Display.prototype.removeWidget = function() {
      return $(this.container).remove();
    };

    return Display;

  })();

}).call(this);

(function() {
  namespace("Weather.Widgets");

  Weather.Widgets.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function(widgetData) {
      return _.template("<div class=\"widget\" data-id=\"weather-widget-wrapper\">\n  <div class=\"widget-header\">\n    <h2 class=\"widget-title\">Weather</h2>\n    <span class='widget-close' data-id='weather-close'>×</span>\n    <div class=\"widget-form\" data-id=\"weather-form\">\n      <input name=\"weather-search\" type=\"text\" autofocus=\"true\">\n      <button id=\"weather\" data-id=\"weather-button\">Get current weather</button><br>\n    </div>\n  </div>\n  <div class=\"widget-body\" data-id=\"weather-output\"></div>\n</div>");
    };

    Templates.renderCurrentConditions = function(weatherObj) {
      return _.template("<p><%= display_location.full %> <%= temp_f %>&deg; F</p>\n<p><%= weather %></p>\n<p><img src='<%= icon_url %>'></p>", weatherObj);
    };

    return Templates;

  })();

}).call(this);
