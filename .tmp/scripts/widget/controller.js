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
