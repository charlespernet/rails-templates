## WIP On template to convert lewagon/rails-template to modern webpack
# Next: Full templates to start with for projects weeks


## Process

- Remove gems from your Gemfile :
  - font-awesome-sass
  - bootstrap-sass
  - sassc-rails

- Install Boostrap 4 via Yarn
  - also add jquery popper.js and rails-ujs
- rename app/javascript to app/frontend
- rename webpack entry point to app/frontend instead of app/javascript
- Add Jquery and popper.js plugins to webpack environment.js and turbolinks maybe

- move 'app/assets/stylesheets' folder to app/frontend/stylesheets
- add index.js to this folder and fill with `import './application';`

- Import bootstrap and stylesheets in packs/application.js
- Do not forget to start rails-ujs from here, and turbolinks if you want it
- Remove `stylesheet_link_tag` and `javascript_link_tag` from `application.html`

- remove app/assets/stylesheets & app/assets/javascript folders
  careful if you have existing javascript we didn't import it to new folder

- run bundle  
- run yarn  
