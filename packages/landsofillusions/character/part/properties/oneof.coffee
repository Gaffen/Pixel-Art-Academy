AE = Artificial.Everywhere
LOI = LandsOfIllusions

class LOI.Character.Part.Property.OneOf extends LOI.Character.Part.Property
  constructor: (@options = {}) ->
    super

    @type = 'oneOf'

    return unless @options.dataLocation

    # One-of properties simply hold a part of the given type.
    if partClass = LOI.Character.Part.getClassForType @options.type
      @part = partClass.create
        dataLocation: @options.dataLocation
        parent: @
