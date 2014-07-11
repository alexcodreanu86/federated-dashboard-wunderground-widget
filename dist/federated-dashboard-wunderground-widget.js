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

(function() {
  namespace('Weather');

  Weather.Controller = (function() {
    function Controller() {}

    Controller.bind = function() {
      return $('[data-id=weather-button]').click((function(_this) {
        return function() {
          return _this.getCurrentWeather(Weather.Display.getInput());
        };
      })(this));
    };

    Controller.getCurrentWeather = function(zipcode) {
      return Weather.API.getCurrentConditions(zipcode, Weather.Display.showWeather);
    };

    Controller.setupWidgetIn = function(container, apiKey) {
      Weather.Display.showFormIn(container);
      Weather.API.key = apiKey;
      return this.bind();
    };

    return Controller;

  })();

}).call(this);

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

(function() {
  namespace('Weather');

  Weather.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function() {
      return _.template("<div class=\"widget\" data-id=weather-widget-wrapper>\n  <div class=\"widget-header\">\n    <h2 class=\"widget-title\">Weather</h2>\n    <div data-id=\"weather-form\">\n      <input name=\"weather-search\" type=\"text\" autofocus=\"true\">\n      <button id=\"weather\" data-id=\"weather-button\">Get current weather</button><br>\n    </div>\n  </div>\n  <div class=\"widget-body\" data-id=\"weather-output\"></div>\n</div>");
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
    function Controller(container) {
      this.container = container;
    }

    Controller.prototype.initialize = function() {
      return $(this.container).append("</h1>REPLACE THIS WITH REAL CONTENT</h1>");
    };

    Controller.prototype.getContainer = function() {
      return this.container;
    };

    return Controller;

  })();

}).call(this);

(function() {


}).call(this);
