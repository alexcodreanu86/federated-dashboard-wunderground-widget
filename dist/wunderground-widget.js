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
      return "http://api.wunderground.com/api/" + window.apiKey + "/conditions/q/" + zipcode + ".json";
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
          return _this.getCurrentWeather(Weather.View.getInput());
        };
      })(this));
    };

    Controller.getCurrentWeather = function(zipcode) {
      return Weather.API.getCurrentConditions(zipcode, Weather.View.showWeather);
    };

    Controller.setupWidgetIn = function(container, apiKey) {
      Weather.View.displayFormIn(container);
      window.apiKey = apiKey;
      return this.bind();
    };

    return Controller;

  })();

}).call(this);

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
        url: './scripts/weatherTemplate.ejs'
      }).render(weatherObj);
    };

    View.displayFormIn = function(selector) {
      var formHtml;
      formHtml = this.renderForm();
      return $(selector).html(formHtml);
    };

    View.renderForm = function() {
      return new EJS({
        url: './scripts/formTemplate.ejs'
      }).render({});
    };

    return View;

  })();

}).call(this);
