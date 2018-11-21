# Code from lewagon to stop spring process ?
run 'pgrep spring | xargs kill -9'

# remove bootstrap-sass and font-awesome-sass from the Gemfile of your project
# Another approach would be to totally rewrite Gemfile but we'll lose gems installed by student
# ====OSX Only====
run "sed -i '' '/bootstrap-sass/d' Gemfile"
run "sed -i '' '/font-awesome-sass/d' Gemfile"
# ===UNBUNTU (untested)====
# run "sed '/bootstrap-sass/d' Gemfile"
# run "sed '/font-awesome-sass/d' Gemfile"

# Install Boostrap 4
run 'yarn add bootstrap jquery popper.js turbolinks rails-ujs'

# rename app/javascript to app/frontend
run 'mv app/javascript app/frontend/'

# rename webpack entry point to app/frontend instead of app/javascript
run 'rm config/webpacker.yml'
file 'config/webpacker.yml', <<-YML
  # Note: You must restart bin/webpack-dev-server for changes to take effect

  default: &default
  source_path: app/frontend
  source_entry_path: packs
  public_output_path: packs
  cache_path: tmp/cache/webpacker

  # Additional paths webpack should lookup modules
  # ['app/assets', 'engine/foo/app/assets']
  resolved_paths: []

  # Reload manifest.json on all requests so we reload latest compiled packs
  cache_manifest: false

  extensions:
    - .js
    - .sass
    - .scss
    - .css
    - .module.sass
    - .module.scss
    - .module.css
    - .png
    - .svg
    - .gif
    - .jpeg
    - .jpg

  development:
  <<: *default
  compile: true

  # Reference: https://webpack.js.org/configuration/dev-server/
  dev_server:
    https: false
    host: localhost
    port: 3035
    public: localhost:3035
    hmr: false
    # Inline should be set to true if using HMR
    inline: true
    overlay: true
    compress: true
    disable_host_check: true
    use_local_ip: false
    quiet: false
    headers:
      'Access-Control-Allow-Origin': '*'
    watch_options:
      ignored: /node_modules/


  test:
  <<: *default
  compile: true

  # Compile test packs to a separate directory
  public_output_path: packs-test

  production:
  <<: *default

  # Production depends on precompilation of packs prior to booting for performance.
  compile: false

  # Cache manifest.json for performance
  cache_manifest: true
YML

# Replace environment.js
run 'rm config/webpack/environment.js'
file 'config/webpack/environment.js', <<-JAVASCRIPT
  const { environment } = require('@rails/webpacker')
  const webpack = require('webpack')
  environment.plugins.set('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  }))

  module.exports = environment
JAVASCRIPT

#move css architecture from app/assets/stylesheets to app/frontend/stylesheets
run 'mv app/assets/stylesheets/ app/frontend/stylesheets'

#add index.js to this folder fill with `import './application';`
file 'app/frontend/stylesheets/index.js', "import './application';"

# replace app/frontend/packs/application.js
run 'rm app/frontend/packs/application.js'
file 'app/frontend/packs/application.js', <<-JAVASCRIPT
  import Rails from 'vendor/rails-ujs';
  import Turbolinks from 'turbolinks';
  import { definitionsFromContext } from 'stimulus/webpack-helpers';

  // TODO: remove when removing jQuery
  window.$ = window.jQuery = require('jquery');

  import 'bootstrap';
  import 'stylesheets';

  // Rails UJS
  Rails.start();

  // Turbolinks
  Turbolinks.start();
JAVASCRIPT

# replace in `application.html`
# WARNING ! Replace all layout this can break student work
run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.erb', <<-HTML
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>TODO</title>
  <%= csrf_meta_tags %>
  <%= action_cable_meta_tag %>
  <%= stylesheet_pack_tag 'application', media: 'all' %>
</head>
<body>
  <%= render 'shared/navbar' %>
  <%= render 'shared/flashes' %>
  <%= yield %>
  <%= javascript_pack_tag 'application' %>
</body>
</html>
HTML

# remove app/assets/stylesheets & app/assets/javascript folders
# careful il you have existing javascript
# WARNING ! Didn't move js (assuming there is not any yet)
run 'rm -rf app/assets/stylesheets/'
run 'rm -rf app/assets/javascripts/'

# run bundle & yarn
run 'bundle install'
run 'yarn install'
