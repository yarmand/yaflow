App.shootingsController = Ember.ArrayController.create
  loadAll: (data) ->
    this.findAll()

  findAll: () ->
    this.set('content', App.store.findAll(App.Shooting))
