LOI = LandsOfIllusions

class LOI.Character.Part.Property.Array extends LOI.Character.Part.Property
  # An array property is a node with fields giving the order (with a floating point number) of its parts.
  # node
  #   fields
  #     {order1}
  #     {order2}
  #     ...
  constructor: (@options = {}) ->
    super

    @type = 'array'

    return unless @options.dataLocation

    @parts = new ReactiveField []

    @partsByOrder = {}

    # Instantiate array parts that are in the data.
    @_arrayAutorun = Tracker.autorun =>
      partsNode = @options.dataLocation()
      return unless partsNode

      return unless fields = partsNode.data()?.fields

      orderedFieldKeys = _.sortBy _.keys(fields), (orderKey) -> parseFloat orderKey
      @_highestOrder = if orderedFieldKeys.length then parseFloat _.last orderedFieldKeys else null

      parts = for fieldKey in orderedFieldKeys
        # Create a property that reads from data location with this order key.
        partData = fields[fieldKey]
        part = @partsByOrder[fieldKey]

        # If we have the part already, make sure it's of the correct type.
        unless part?.options.type is partData.type
          Tracker.nonreactive =>
            part = LOI.Character.Part.Types[partData.type].create
              dataLocation: @options.dataLocation.child fieldKey

          # Add the _id field so that foreach knows to reuse/recreate the field.
          part._id = Random.id()

          @partsByOrder[fieldKey] = part

        part

      @parts parts

  destroy: ->
    super

    @_arrayAutorun.stop()

  newPart: (type) ->
    newOrder = if @_highestOrder? then @_highestOrder + 1 else 0

    newDataLocation = @options.dataLocation.child newOrder

    # Set field meta data.
    newDataLocation.setMetaData
      type: type

    LOI.Character.Part.Types[type].create
      dataLocation: newDataLocation
