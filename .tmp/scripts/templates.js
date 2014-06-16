(function() {
  namespace('Weather');

  Weather.Template = (function() {
    function Template() {}

    Template.renderForm = function() {
      return _.template("<input name=\"weather-search\" type=\"text\"><br>\n<button id=\"weather\" data-id=\"weather-button\">Get current weather</button><br>\n<div data-id=\"weather-output\"></div>");
    };

    Template.renderCurrentConditions = function(weatherObj) {
      return _.template("<p><%= display_location.full %> <%= temp_f %>&deg; F</p>\n<p><%= weather %></p>\n<p><img src='<%= icon_url %>'></p>", weatherObj);
    };

    return Template;

  })();

}).call(this);
