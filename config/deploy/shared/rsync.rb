desc "Rsync production's system folder to current stage"
task :rsync_system, :roles => :app do
  if rails_env == 'production'
    raise Capistrano::Error, "can't rsync production to production"
  end
  prod_path = "#{base_directory}/#{application}_production/shared/system/"
  curr_path = "#{shared_path}/system"
  run "rsync -zuogthr --delete-after #{prod_path} #{curr_path}"
end