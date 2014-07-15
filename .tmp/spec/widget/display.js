(function() {
  var container1, container2, newDisplay, setupOneContainer, setupTwoContainers, weatherObj;

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
    return setFixtures(" <div data-id='widget-container-1'></div>");
  };

  setupTwoContainers = function() {
    return setFixtures("<div data-id='widget-container-1'></div>\n<div data-id='widget-container-2'></div>");
  };

  newDisplay = function(container) {
    return new Weather.Widget.Display(container);
  };

  container1 = "[data-id=widget-container-1]";

  container2 = "[data-id=widget-container-2]";

  describe("Weather.Widget.Display", function() {
    it("stores the container it is initialized with", function() {
      var display;
      display = newDisplay(container1);
      return expect(display.container).toEqual(container1);
    });
    it("setupWidget is setting up the widget in it's container", function() {
      var display;
      display = newDisplay(container1);
      setupOneContainer();
      display.setupWidget();
      return expect(container1).toContainElement('.widget .widget-header');
    });
    it("getInput returns the input in the field in it's own container", function() {
      var display1, display2;
      setupTwoContainers();
      display1 = newDisplay(container1);
      display2 = newDisplay(container2);
      display1.setupWidget();
      display2.setupWidget();
      $("" + container1 + " [name=weather-search]").val("text1");
      $("" + container2 + " [name=weather-search]").val("text2");
      expect(display1.getInput()).toEqual("text1");
      return expect(display2.getInput()).toEqual("text2");
    });
    it("showCurrentWeather is displaying the weather properly in its container", function() {
      var display, display2;
      setupTwoContainers();
      display = newDisplay(container1);
      display2 = newDisplay(container2);
      display.setupWidget();
      display2.setupWidget();
      display.showCurrentWeather(weatherObj.current_observation);
      expect($("" + container1 + " [data-id=weather-output]")).toContainText('Niles');
      return expect($("" + container2 + " [data-id=weather-output]")).not.toContainText('Niles');
    });
    it("hideForm is hiding the form", function() {
      var display;
      setupOneContainer();
      display = newDisplay(container1);
      display.setupWidget();
      display.hideForm();
      return expect($("" + container1 + " [data-id=weather-form]").attr('style')).toEqual('display: none;');
    });
    it("showForm is showing the form", function() {
      var display;
      setupOneContainer();
      display = newDisplay(container1);
      display.setupWidget();
      display.hideForm();
      display.showForm();
      return expect($("" + container1 + " [data-id=weather-form]").attr('style')).not.toEqual('display: none;');
    });
    return it("removeWidget is removing the widget's content", function() {
      var display;
      setupOneContainer();
      display = newDisplay(container1);
      display.setupWidget();
      display.removeWidget();
      return expect($(container1)).not.toContainElement("[data-id=weather-widget-wrapper]");
    });
  });

}).call(this);
