(function() {
  var container, setupWidgetContainer;

  setupWidgetContainer = function() {
    return setFixtures(" <div data-id='widget-container-1'></div>");
  };

  container = "[data-id=widget-container-1]";

  describe("Weather.Widget.Controller", function() {
    it("stores the container that it is initialized with", function() {
      var controller;
      controller = new Weather.Widget.Controller(container);
      return expect(controller.getContainer()).toEqual(container);
    });
    return it("sets itself up in the container when it is initialized with", function() {
      var controller;
      setupWidgetContainer();
      controller = new Weather.Widget.Controller(container);
      controller.initialize();
      return expect($(container)).not.toBeEmpty();
    });
  });

}).call(this);
