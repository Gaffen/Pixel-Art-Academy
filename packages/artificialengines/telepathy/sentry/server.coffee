Raven = Npm.require 'raven-js'
# Add Sentry.io exeption monitoring if private key exists
if Meteor.settings.private.ravenServerDSN
  Raven.config(Meteor.settings.private.ravenServerDSN).install();
