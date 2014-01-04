#!/usr/bin/env puma

# RAILS_ENV=production bundle exec puma -e production -C ./config/puma.rb

application_path = '/home/rathole/rathole'
directory application_path
environment = :production
daemonize true
pidfile "#{application_path}/tmp/pids/rathole.pid"
state_path "#{application_path}/tmp/pids/rathole.state"
stdout_redirect "#{application_path}/log/rathole.stdout.log", "#{application_path}/log/rathole.stderr.log"
bind "unix://#{application_path}/tmp/sockets/rathole.socket"
