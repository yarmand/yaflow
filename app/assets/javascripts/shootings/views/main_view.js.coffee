

ShootingsApp.MainView = Ember.View.extend

  templateName: "shootings/templates/main"

  shootings: Ember.computed(->
    ShootingsApp.shootingsController.findAll()
  )

  inline_description: Ember.computed(->
    cs = ShootingsApp.mainView.get('current_shooting')
    if(cs)
      return cs.get('inline_content')
  )
ShootingsApp.ShootingSelectorView = Ember.View.extend
  
  edit: (evt) ->
    ShootingsApp.mainView.set('current_shooting',this.content)

Handlebars.registerHelper 'inline_html', (property) ->
  value = Ember.getPath(property)
  new Handlebars.SafeString(value)
