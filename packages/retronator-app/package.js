Package.describe({
  name: 'retronator:app',
  version: '0.28.0',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use('retronator:api');
  api.use('retronator:retronator');
  api.use('retronator:artificialengines');
  api.use('retronator:artificialengines-pages');
  api.use('retronator:retronator-accounts');
  api.use('retronator:retronator-store');
  api.use('retronator:landsofillusions');
  api.use('retronator:pixelartacademy-landingpage');
  api.use('retronator:pixelartacademy-items');
  api.use('retronator:pixelartacademy-season1-episode0');
  api.use('retronator:pixelartacademy-season1-episode1');
  api.use('retronator:pixelartacademy-pixelboy');
  api.use('retronator:pixelartacademy-practice');
  api.use('retronator:pixelartdatabase');
  api.use('retronator:pixelartdatabase-pixeldailies');
  api.use('retronator:sanfrancisco-soma');
  api.use('retronator:sanfrancisco-c3');
  api.use('retronator:sanfrancisco-apartment');
  api.use('retronator:retronator-hq');
  api.use('retronator:retronator-blog');
  api.use('retronator:retronator-residence');
  api.use('retronator:retronator-landsofillusions');
  api.use('retronator:landsofillusions-construct');
  api.use('retronator:landsofillusions-assets');
  api.use('retronator:retropolis-city');
  api.use('retronator:landsofillusions-world');

  // Routing portion, fork from force-ssl.
  api.use('webapp', 'server');
  
  // Make sure we come after livedata, so we load after the sockjs server has been instantiated.
  api.use('ddp', 'server');

  api.addServerFile('routing-server');

  // Add other files.
  api.addUnstyledComponent('app');

  // Layouts

  api.addFile('layouts/layouts');
  api.addUnstyledComponent('layouts/adminaccess/adminaccess');
  api.addUnstyledComponent('layouts/useraccess/useraccess');
  api.addUnstyledComponent('layouts/publicaccess/publicaccess');

});
