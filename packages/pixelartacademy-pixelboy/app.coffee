AM = Artificial.Mirage
LOI = LandsOfIllusions
PAA = PixelArtAcademy

class PAA.PixelBoy.App extends AM.Component

  @displayName: ->
    throw new Meteor.Error 'unimplemented', "You must specify app's display name."

  displayName: -> @constructor.displayName()

  @urlName: ->
    throw new Meteor.Error 'unimplemented', "You must specify app's url name."

  urlName: -> @constructor.urlName()
