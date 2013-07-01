role :web, "beta.balticit.ru"
role :app, "beta.balticit.ru"
role :db,  "beta.balticit.ru", :primary => true

set :rails_env, "production"
set :branch, "master"

set :deploy_to, "/var/www/apps/#{application}_#{stage}"

set :keep_releases, 30

set :current_path, File.join(deploy_to, current_dir) #fix for capistrano-unicorn
