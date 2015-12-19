$ = require('jquery')
riot = require('riot')
{Component, Panel} = require('dripper/component')

class PreferencesDialog
  activate: ->

    @comp = new Component "#{__dirname}/../tag/*.tag"
    dripcap.package.load('main-view').then (pkg) =>
      dripcap.package.load('modal-dialog').then (pkg) =>
        $ =>
          @panel = new Panel
          n = $('<div>').appendTo $('body')
          @_view = riot.mount(n[0], 'preferences-dialog')[0]
          $(@_view.root).find('.content').append($('<div class="root-container" />').append(@panel.root))

          dripcap.action.on 'Core: Preferences', =>
            @_view.show()
            @_view.update()

  updateTheme: (theme) ->
    @comp.updateTheme theme

  deactivate: ->
    dripcap.keybind.unbind 'enter', '[riot-tag=preferences-dialog] .content'
    @_view.unmount()
    @comp.destroy()

module.exports = PreferencesDialog