lock '3.1.0'

set :application, 'rathole'
set :scm, :git
set :repo_url, 'git@git.kimrgrey.org:kimrgrey/kgblogs.git'
set :user, 'rathole'
set :deploy_to, '/home/rathole/rathole'
set :deploy_via, :remote_cache
set :log_level, :debug
set :keep_releases, 5
set :linked_dirs, fetch(:linked_dirs) + %w{public/uploads}
set :linked_files, %w{config/database.yml config/secrets.yml}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
