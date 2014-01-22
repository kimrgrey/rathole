server 'staging.rathole.io', user: 'rathole', roles: %w{web app db}

set :stage, :staging
set :branch, 'master'
