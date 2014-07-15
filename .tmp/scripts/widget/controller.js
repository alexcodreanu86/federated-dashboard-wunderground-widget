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

    return Controller;

  })();

}).call(this);
