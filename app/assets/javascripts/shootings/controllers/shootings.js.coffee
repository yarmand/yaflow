ShootingsApp.shootingsController = Ember.ArrayController.create
  loadAll: (data) ->
    this.findAll()

  findAll: () ->
    this.set('content', ShootingsApp.store.findAll(ShootingsApp.Shooting))
