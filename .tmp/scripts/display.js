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
