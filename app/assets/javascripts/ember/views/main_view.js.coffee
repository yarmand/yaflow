

App.MainView = Ember.View.extend

  templateName: "ember/templates/shootings"

  shootings: Ember.computed(->
    App.shootingsController.findAll()
  )

  inline_description: Ember.computed(->
    cs = App.mainView.get('current_shooting')
    if(cs)
      return cs.get('inline_content')
  )
App.ShootingSelectorView = Ember.View.extend
  
  edit: (evt) ->
    App.mainView.set('current_shooting',this.content)

Handlebars.registerHelper 'inline_html', (property) ->
  value = Ember.getPath(property)
  new Handlebars.SafeString(value)
