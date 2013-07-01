namespace :db do
  namespace :mysql do
    set(:mysql_root_password){ Capistrano::CLI.password_prompt("MySQL root password: ") }
    set(:mysql_db_user_password){ SecureRandom.base64 }
    set :mysql_db_name, "#{application}_#{rails_env}"
    set :mysql_db_user, "#{application}_#{rails_env}"

    def mysql_root_sql(query)
      run "mysql --user=root --password=#{mysql_root_password} -e \"#{query}\""
    end

    desc "Create mysql user"
    task :create_user do
      mysql_root_sql "CREATE USER '#{mysql_db_user}'@'localhost' IDENTIFIED BY '#{mysql_db_user_password}'"
    end

    desc "Grant privileges to user on database"
    task :grant_privileges do
      mysql_root_sql "GRANT ALL PRIVILEGES ON #{mysql_db_name}.* TO '#{mysql_db_user}'@'localhost' IDENTIFIED BY '#{mysql_db_user_password}' WITH GRANT OPTION"
    end

    desc "Create mysql database"
    task :create_database do
      mysql_root_sql "CREATE DATABASE IF NOT EXISTS #{mysql_db_name}"
    end

    desc "Create database.yml in shared path"
    task :create_config do
      db_config = <<-EOF
      base: &base
        adapter: mysql2
        encoding: utf8
        reconnect: false
        pool: 5
        username: #{mysql_db_user}
        password: #{mysql_db_user_password}

      #{rails_env}:
        database: #{application}_#{rails_env}
        <<: *base
      EOF

      run "mkdir -p #{shared_path}/private/config"
      put db_config, "#{shared_path}/private/config/database.yml"
    end

   task :setup do
     create_config
     create_user
     create_database
     grant_privileges
   end

  end
end