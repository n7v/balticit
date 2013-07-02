namespace :nginx do
  desc "update site config"
  task :update_site_config, :roles => :app do
    local_conf = "#{latest_release}/config/nginx/#{stage}.conf"
    nginx_avail_site_conf = "/etc/nginx/sites-available/#{application}_#{stage}.conf"
    nginx_enabled_site_conf = "/etc/nginx/sites-enabled/#{application}_#{stage}.conf"
    run "sudo cp -f #{local_conf} #{nginx_avail_site_conf}"
    run "sudo ln -nfs #{nginx_avail_site_conf} #{nginx_enabled_site_conf}"
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