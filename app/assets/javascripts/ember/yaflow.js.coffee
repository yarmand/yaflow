#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates

window.Yaflow = Ember.Application.create

  start: ->
    mainView = Yaflow.MainView.create()
    mainView.appendTo ($ "#shootings")
