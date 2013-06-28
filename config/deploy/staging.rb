role :web, "stage.balticit.ru"
role :app, "stage.balticit.ru"
role :db,  "stage.balticit.ru", :primary => true

set :rails_env, "staging"
set :branch, "stage"

set :deploy_to, "/var/www/apps/#{application}_#{stage}"

set :keep_releases, 5