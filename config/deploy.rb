require 'bundler/capistrano'
require 'capistrano-helpers/migrations'
require 'capistrano-helpers/shared'
require 'capistrano-helpers/privates'

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "balticit"

set :scm, :git
set :repository,  "git@github.com:balticit/balticit.git"

set :deploy_via, :remote_cache

set :user, "rvm_user"
set :use_sudo, false

set :rvm_type, :system 
set :rvm_ruby_string, "ruby-2.0.0-head"
set :rvm_install_with_sudo, true
set :rvm_autolibs_flag, "readonly"

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

require "rvm/capistrano"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

require 'capistrano-unicorn'

Dir.glob('config/deploy/shared/*.rb').each{ |file| load file }

#place your database.yml to #{shared_path}/private/config
set :privates, %w{
  config/database.yml
}
