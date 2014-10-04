describe "Weather.Controller", ->
  it "setupWidgetIn is setting up a widget instance in the desired element", ->
    setFixtures(sandbox())
    Weather.Controller.setupWidgetIn({container: '#sandbox', key: "123456"})
    html = $('#sandbox')

    expect(html).toContainElement('[name=widget-input]')
    expect(html).toContainElement('[data-name=form-button]')
    expect(html).toContainElement('[data-name=widget-output]')
