AE = Artificial.Everywhere
AM = Artificial.Mirage
LOI = LandsOfIllusions

class LOI.Components.MediaPlayer extends AM.Component
  @register 'LandsOfIllusions.Components.MediaPlayer'

  @version: -> '0.0.1'

  constructor: (@options) ->
    super

  events: ->
    super.concat
      'click .jp-play': @onClickPlay
      'click .jp-pause': @onClickPause
      'click .jp-stop': @onClickStop
      'click .jp-previous': @onClickPrevious
      'click .jp-next': @onClickNext
      'click .jp-mute': @onClickMute

  onClickCoverButton: (event) ->
    @hiImJustAPlaceHolderBecauseMarcDoesntKnowCoffeeVeryWellYet 1

  onClickPrevious: (event) ->
    @currentPageNumber Math.max 1, @currentPageNumber() - 1

  onClickNext: (event) ->
    @currentPageNumber Math.min @pages.length, @currentPageNumber() + 1
