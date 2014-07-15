(function() {
  var container, newController, setupOneContainer, weatherObj;

  weatherObj = {
    current_observation: {
      display_location: {
        full: "Niles IL"
      },
      weather: "Partly Cloudy",
      temp_f: "77.9",
      icon_url: "http://icons.wxug.com/i/c/k/partlycloudy.gif"
    }
  };

  setupOneContainer = function() {
    return setFixtures("<div data-id='widget-container-1'></div>");
  };

  container = "[data-id=widget-container-1]";

  newController = function(container) {
    return new Weather.Widget.Controller(container, "1243");
  };

  describe("Weather.Widget.Controller", function() {
    it("stores the container that it is initialized with", function() {
      var controller;
      controller = newController(container);
      return expect(controller.getContainer()).toEqual(container);
    });
    it("stores a new instance of Weather.Widget.Display when instantiated", function() {
      var controller;
      controller = newController(container);
      return expect(controller.display).toBeDefined();
    });
    it("initialize sets widget up in its container", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      return expect($(container)).not.toBeEmpty();
    });
    it("initialize is binding the controller", function() {
      var controller, spy;
      controller = newController(container);
      spy = spyOn(controller, 'bind');
      controller.initialize();
      return expect(spy).toHaveBeenCalled();
    });
    it("bind is displaying the weather when the button is clicked", function() {
      var controller, data, spy;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      spy = spyOn(Weather.API, 'getCurrentConditions');
      $("" + container + " [name=weather-search]").val("Niles IL");
      $("" + container + " [data-id=weather-button]").click();
      data = {
        key: '1243',
        zipcode: 'Niles IL'
      };
      return expect(spy).toHaveBeenCalledWith(data, controller.display);
    });
    it("hideForm is hiding the form", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      controller.hideForm();
      return expect($("" + container + " [data-id=weather-form]").attr('style')).toEqual('display: none;');
    });
    it("showForm is showing the form", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      controller.hideForm();
      controller.showForm();
      return expect($("" + container + " [data-id=weather-form]").attr('style')).not.toEqual('display: none;');
    });
    return it("removeContent is removing the widget's content", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      controller.removeContent();
      return expect($(container)).not.toContainElement("[data-id=weather-widget-wrapper]");
    });
  });

}).call(this);
