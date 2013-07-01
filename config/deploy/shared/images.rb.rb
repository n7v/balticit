
namespace :images do
  desc 'Sync images to local workstation'
  task :load_from_server, :roles => :app do
    find_servers_for_task(current_task).each do |current_server|
      remote_dir = "#{shared_path}/system"
      local_dir  = './public'
      options    = '--progress --delete -av'
      user_host  = "#{user}@#{current_server.host}"
      cmd        = "rsync #{options} #{user_host}:#{remote_dir} #{local_dir}"
      IO.popen(cmd) do |f|
        while line = f.gets do
          puts line
        end
      end
    end
  end
end