AM = Artificial.Mirage
LOI = LandsOfIllusions
PAA = PixelArtAcademy

class PAA.Layouts.PlayerAccess extends BlazeLayoutComponent
  @register 'PixelArtAcademy.Layouts.PlayerAccess'

  @title: ->
    "Pixel Art Academy"

  loading: ->
    Meteor.loggingIn()

  characters: ->
    user = Retronator.Accounts.User.documents.findOne Meteor.userId(),
      fields:
        characters: 1

    user?.characters

  renderPage: (parentComponent) ->
    @_renderRegion 'page', parentComponent

  events: ->
    super.concat
      'click .load-character': @onClickLoadCharacter

  onClickLoadCharacter: (event) ->
    characterId = @currentData()._id
    LOI.switchCharacter characterId
