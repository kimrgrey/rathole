Capybara.asset_host = 'http://rathole.dev'

Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = true
end