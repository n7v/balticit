namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    hostname = find_servers_for_task(current_task).first
    exec "ssh -l #{user} #{hostname} -t 'source ~/.bashrc && export LC_ALL=ru_RU.utf8 && cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rails c'"
  end
end