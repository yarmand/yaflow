#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates

window.App= Ember.Application.create

  start: ->
    mainView = App.MainView.create()
    mainView.appendTo ($ "#container")
    this.set('mainView',mainView)

App.store = DS.Store.create
  adapter:  DS.RESTAdapter.create({bulkCommit: false})
  revision: 4

App.displayError = (e) ->
  if (typeof e == 'string')
    alert(e)
  else if (typeof e == 'object' && e.responseText != undefined)
    alert(e.responseText)
  else
    alert("An unexpected error occurred.")


