namespace :nginx do
  desc "Copy configs to nginx directory"
  task :copy_config, :roles => :app do
    run "sudo cp -rf #{latest_release}/config/nginx/#{application}-#{stage}.conf /etc/nginx/conf.d"
  end

  desc "reload nginx"
  task :reload, :roles => :app do
    run "sudo /etc/init.d/nginx reload"
  end

  desc "restart nginx"
  task :restart, :roles => :app do
    run "sudo /etc/init.d/nginx restart"
  end

  desc "stop nginx"
  task :stop, :roles => :app do
    run "sudo /etc/init.d/nginx stop"
  end

  desc "start nginx"
  task :start, :roles => :app do
    run "sudo /etc/init.d/nginx start"
  end

  desc "Check nginx status"
  task :status, :roles => :app do
    run "sudo /etc/init.d/nginx status"
  end
end