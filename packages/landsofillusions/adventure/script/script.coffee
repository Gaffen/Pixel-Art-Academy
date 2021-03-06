LOI = LandsOfIllusions
AM = Artificial.Mummification

class LOI.Adventure.Script
  @_scriptClassesById = {}

  @getClassForId: (id) ->
    @_scriptClassesById[id]

  @initialize: ->
    # Store script class by ID.
    @_scriptClassesById[@id()] = @

  constructor: (@options) ->
    @startNode = @options.startNode

    # Gather all the nodes in this graph for easier processing.
    @nodes = []

    # First we add the main node.
    @_addNode @startNode

    # Second we add all the label nodes since some might be only reachable from jump calls.
    @_addNode label for labelName, label of @startNode.labels

    # Now process the script nodes.
    @_processOnServer() if Meteor.isServer
    @_processOnClient() if Meteor.isClient

  _processOnServer: ->
    # On the server we need to prepare translation documents for the script.

  _processOnClient: ->
    # On the client we need to load the translation documents.
    character = LOI.character()

    # Process nodes.
    for node in @nodes
      # Replace jump nodes with actual label nodes they point to.
      for property in ['node', 'next']
        if node[property] instanceof @constructor.Nodes.Jump
          jumpNode = node[property]
          node[property] = @startNode.labels[jumpNode.labelName]

      # Replace char actor with character instance.
      node.actor = character if node.actor is 'char'

    # Set the script reference to all nodes.
    node.script = @ for node in @nodes

    # Prepare the state objects.
    @stateAddress = new LOI.StateAddress "scripts.#{@id()}"
    @state = new LOI.StateObject address: @stateAddress

    @ephemeralState = new LOI.EphemeralStateObject

    @_stateChangeAutorun = AM.PersistentStorage.persist
      storageKey: "#{@id()}.state"
      storage: sessionStorage
      field: @ephemeralState.field()

    # On the client, do any custom initialization logic.
    @initialize()

  destroy: ->
    @_stateChangeAutorun.stop()

  id: ->
    @startNode.id

  initialize: -> # Override to setup the script on the client.

  # Sets things that have a shorthand name in the script (actors, thing variables in script context).
  setThings: (things = {}) ->
    @things = things

    # Replace actor names with actual thing instances.
    for node in @nodes
      if node.actor and _.isString node.actor
        continue unless things[node.actor]

        node.actor = things[node.actor]

  setCurrentThings: (thingClasses) ->
    Tracker.autorun (computation) =>
      return unless LOI.adventureInitialized()

      things = {}
      for key, thingClass of thingClasses
        return unless things[key] = LOI.adventure.getCurrentThing thingClass

      computation.stop()

      @setThings things

  setCallbacks: (callbacks) ->
    # Set callbacks to callback nodes
    for name, callback of callbacks
      unless @startNode.callbacks[name]
        console.warn "Unknown callback", name
        return

      for callbackNode in @startNode.callbacks[name]
        callbackNode.callback = callback

    # We expect all callbacks to be set in one go so warn about any that were left unset.
    for name, callbacks of @startNode.callbacks
      console.warn "Callback for #{name} was not set" unless callbacks[0]?.callback

  _addNode: (node) ->
    # Add the node only if it hasn't already added.
    return if not node or node in @nodes

    @nodes.push node

    # Recursively add the next and node node.
    @_addNode node.next
    @_addNode node.node
