# config valid only for current version of Capistrano
lock "3.7.1"

set :application, "damon"
#set :repo_url, 'git@github.com:plusjade/damon.git'
set :repo_url, 'https://github.com/plusjade/damon.git'
set :repo_tree, 'web'

set :user, "rails"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1


# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, '/home/rails-app'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_files, "config/database.yml", "config/sesames.json"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  after :published, :restart do
    on roles(:all) do
      within current_path do
        execute("chown -R rails:rails /home/rails-app/shared/tmp")
      end

      within release_path do
        execute("/etc/init.d/unicorn restart")
      end
    end
  end
end
