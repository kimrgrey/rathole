set :application, 'kgblogs'
set :scm, :git
set :repo_url, 'http://git.kimrgrey.org/kimrgrey/kgblogs.git'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  after :finishing, 'deploy:cleanup'
end
