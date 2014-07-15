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

    return Controller;

  })();

}).call(this);
