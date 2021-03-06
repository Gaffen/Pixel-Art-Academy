AB = Artificial.Base
AM = Artificial.Mirage
PADB = PixelArtDatabase

class PADB.PixelDailies.Pages.YearReview.About extends AM.Component
  @register 'PixelArtDatabase.PixelDailies.Pages.YearReview.About'

  @title: (options) ->
    "Retronator // Top Pixel Dailies #{options.year}: About"

  @description: (options) ->
    "Learn about Retronator's Top Pixel Dailies Archive for #{options.year}."

  year: ->
    AB.Router.getParameter 'year'

  background: ->
    # The second artwork from the backgrounds array is used on the about page.
    PADB.PixelDailies.Pages.YearReview.Years[@year()].backgrounds[1]
