role :web, "beta.balticit.ru"
role :app, "beta.balticit.ru"
role :db,  "beta.balticit.ru", :primary => true

set :rails_env, "production"
set :branch, "master"

set :deploy_to, "/var/www/#{application}_#{stage}"

set :keep_releases, 30
