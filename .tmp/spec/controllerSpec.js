(function() {
  var clickOn, container1, container2, resetWidgetsContainer, setSandbox, setupTwoContainers, weatherObj;

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

  clickOn = function(element) {
    return $(element).click();
  };

  resetWidgetsContainer = function() {
    return Weather.Controller.widgets = [];
  };

  setSandbox = function() {
    return setFixtures(sandbox());
  };

  setupTwoContainers = function() {
    return setFixtures("<div data-id='widget-container-1'></div>\n<div data-id='widget-container-2'></div>");
  };

  container1 = "[data-id=widget-container-1]";

  container2 = "[data-id=widget-container-2]";

  describe("Weather.Controller", function() {
    it("widgets container is empty on initialization", function() {
      var container;
      resetWidgetsContainer();
      container = Weather.Controller.getWidgets();
      return expect(container.length).toBe(0);
    });
    it("setupWidgetIn is setting up a widget instance in the desired element", function() {
      var html;
      resetWidgetsContainer();
      setSandbox();
      Weather.Controller.setupWidgetIn('#sandbox', "123456");
      html = $('#sandbox');
      expect(html).toContainElement('[name=weather-search]');
      expect(html).toContainElement('[data-id=weather-button]');
      return expect(html).toContainElement('[data-id=weather-output]');
    });
    it("setupWidgetIn is adding the initialized widget to the widgets container", function() {
      resetWidgetsContainer();
      setSandbox();
      Weather.Controller.setupWidgetIn('#sandbox', "123456");
      return expect(Weather.Controller.getWidgets().length).toEqual(1);
    });
    it("hideForms is hiding the forms of all the widgets that are initialized", function() {
      resetWidgetsContainer();
      setupTwoContainers();
      Weather.Controller.setupWidgetIn(container1, "123456");
      Weather.Controller.setupWidgetIn(container2, "123456");
      Weather.Controller.hideForms();
      expect($("" + container1 + " [data-id=weather-form]").attr('style')).toEqual('display: none;');
      return expect($("" + container2 + " [data-id=weather-form]").attr('style')).toEqual('display: none;');
    });
    return it("showForms is showing the forms of all the widgets that are initialized", function() {
      resetWidgetsContainer();
      setupTwoContainers();
      Weather.Controller.setupWidgetIn(container1, "123456");
      Weather.Controller.setupWidgetIn(container2, "123456");
      Weather.Controller.hideForms();
      Weather.Controller.showForms();
      expect($("" + container1 + " [data-id=weather-form]").attr('style')).not.toEqual('display: none;');
      return expect($("" + container2 + " [data-id=weather-form]").attr('style')).not.toEqual('display: none;');
    });
  });

}).call(this);
