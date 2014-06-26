(function() {
  namespace('Weather');

  Weather.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function() {
      return _.template("<input name=\"weather-search\" type=\"text\"><br>\n<button id=\"weather\" data-id=\"weather-button\">Get current weather</button><br>\n<div data-id=\"weather-output\"></div>");
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
