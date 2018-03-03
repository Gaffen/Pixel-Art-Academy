Raven = Npm.require 'raven-js'
# Add Sentry.io exeption monitoring if private key exists
if Meteor.settings.public.ravenClientDSN
  Raven.config(Meteor.settings.public.ravenClientDSN).install();
