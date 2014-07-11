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
