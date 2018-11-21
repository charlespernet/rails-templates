## WIP On template to convert lewagon/rails-template to modern webpack
Next: Full templates to start with for projects weeks

## How can you help ?
  Try to run a rails new with lewagon/rails-templates devise or minimal

  ```
  rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/devise.rb \
  CHANGE_THIS_TO_YOUR_RAILS_APP_NAME
  ```

  from this repo run
  ```
  rails app:template \ LOCATION=https://raw.githubusercontent.com/charlespernet/rails-templates/master/lewagon_devise_to_modern_webpack.rb
  ```

  Try to help me fix stuff !

## Process Followed

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
