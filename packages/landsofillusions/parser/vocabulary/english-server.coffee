AB = Artificial.Babel

Document.startup ->
  return if Meteor.settings.startEmpty

  # Generate all default english vocabulary phrases
  phrases =
    Directions:
      North: ['north', 'n']
      South: ['south', 's']
      East: ['east', 'e']
      West: ['west', 'w']
      Northeast: ['northeast', 'ne']
      Northwest: ['northwest', 'nw']
      Southeast: ['southeast', 'se']
      Southwest: ['southwest', 'sw']
      In: ['in', 'enter', 'inside']
      Out: ['out', 'exit', 'outside']
      Up: ['up', 'upstairs']
      Down: ['down', 'downstairs']
      Back: ['back']

    Verbs:
      GoToLocationName: ['go to', 'travel to', 'enter', 'leave to']
      GoToDirection: ['go', 'towards', 'move', 'travel']
      ExitLocation: ['exit', 'leave']
      TalkTo: ['talk to', 'talk with', 'speak to', 'speak with', 'chat with']
      LookAt: ['look at', 'examine', 'see', 'view', 'watch']
      Look: ['look', 'look around', 'description']
      Use: ['use']
      Press: ['press', 'push']
      Read: ['read']
      WhatIs: ['what is']
      WhoIs: ['who is']
      Get: ['get', 'take', 'pick up', 'grab']
      SitDown: ['sit down']
      SitIn: ['sit in']
      Stand: ['stand up']
      Open: ['open']
      Close: ['close']
      Drink: ['drink']
      DrinkFrom: ['drink from']
      Return: ['return']
      ReturnTo: ['return _ to']
      GiveTo: ['give _ to']
      UseIn: ['use _ in']
      UseWith: ['use _ with']
      ShowTo: ['show _ to', 'present _ to']
      Show: ['show', 'present']
      LookIn: ['look in']
      WakeUp: ['wake up', 'awaken']
      Buy: ['buy', 'purchase']
      Board: ['board', 'take']
      ListenTo: ['listen to', 'hear']

    Pronouns:
      Subjective:
        Feminine: ['she']
        Masculine: ['he']
        Neutral: ['they']
      Objective:
        Feminine: ['her']
        Masculine: ['him']
        Neutral: ['them']
      Adjective:
        Feminine: ['her']
        Masculine: ['his']
        Neutral: ['their']
      Possessive:
        Feminine: ['hers']
        Masculine: ['his']
        Neutral: ['theirs']

    IgnorePrepositions: ['_', 'from', 'to', 'with', 'is', 'at', 'in', 'up', 'down']

    Questions:
      WhichPlace: ['where']
      WhichThing: ['which']
      WhichPerson: ['who']
      WhichVerb: ['what']

    Debug:
      ResetSections: ['reset sections']

  # Generate default english translations.
  generateDefaultTranslations = (id, phrases) ->
    if _.isObject phrases
      # We are on an object node so generate translations of each property in turn. This
      # also works on the array node, which will use indices as property names.
      for phrase of phrases
        generateDefaultTranslations "#{id}.#{phrase}", phrases[phrase]

    else
      # We are on the leaf node which is one of the default english phrases for this id.
      phrase = phrases

      # We add this phrase into the vocabulary namespace.
      AB.createTranslation 'LandsOfIllusions.Adventure.Parser.Vocabulary', id, phrase

  for rootId, phraseGroup of phrases
    generateDefaultTranslations rootId, phraseGroup
