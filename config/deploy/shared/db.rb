namespace :db do
  task :prepare, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:drop db:create"
  end

  task :schema_load, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:schema:load"
  end

  task :seed, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:seed"
  end

  task :sample, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:load_sample"
  end

  task :backup_name, :roles => :db, :only => { :primary => true } do
    run "mkdir -p #{shared_path}/db_backups"
    backup_time = Time.now.strftime("%Y-%m-%d-%Hh%Mm%Ss%Lms")
    set :backup_file, "#{shared_path}/db_backups/#{stage}-#{rails_env}-snapshot-#{backup_time}.sql"
  end

  desc "Backup your MySQL or PostgreSQL database to shared_path+/db_backups"
  task :dump, :roles => :db, :only => {:primary => true} do
    backup_name
    run("cat #{shared_path}/private/config/database.yml") do |channel, stream, data|
      @environment_info = YAML.load(data)[rails_env]
    end
    dbuser = @environment_info['username']
    dbpass = @environment_info['password']
    environment_database = @environment_info['database']
    dbhost = @environment_info['host']
    dbhost_arg = dbhost ? "-h #{dbhost}" : ""
    adapter = @environment_info['adapter']
    case adapter
    when 'mysql', 'mysql2'
      run "mysqldump --add-drop-table -u #{dbuser} #{dbhost_arg} -p #{environment_database} | bzip2 -c > #{backup_file}.bz2" do |ch, stream, out |
        ch.send_data "#{dbpass}\n" if out=~ /^Enter password:/
      end
    when 'postgresql'
      run "pg_dump -W -c -U #{dbuser} #{dbhost_arg} #{environment_database} | bzip2 -c > #{backup_file}.bz2" do |ch, stream, out |
        ch.send_data "#{dbpass}\n" if out=~ /^Password:/
      end
    else
      raise Capistrano::Error, "Unknown database adapter: #{adapter}"
    end
  end

  desc "Sync your production database to your local workstation"
  task :clone_to_local, :roles => :db, :only => {:primary => true} do
    backup_name
    dump
    get "#{backup_file}.bz2", "/tmp/#{application}.sql.bz2"
    development_info = YAML.load_file("config/database.yml")['development']
    host_arg = development_info['host'] ? "-h #{development_info['host']}" : ''
    adapter = development_info['adapter']
    case adapter
    when 'mysql', 'mysql2'
      run_str = "bzcat /tmp/#{application}.sql.bz2 | mysql -u #{development_info['username']} --password='#{development_info['password']}' #{host_arg} #{development_info['database']}"
    when 'postgresql'
      run_str = "PGPASSWORD=#{development_info['password']} bzcat /tmp/#{application}.sql.bz2 | psql -U #{development_info['username']} #{host_arg} #{development_info['database']}"
    else
      raise Capistrano::Error, "Unknown database adapter: #{adapter}"
    end
    %x(#{run_str})
  end

end
