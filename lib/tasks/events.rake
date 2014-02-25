namespace :events do
  desc "Exports all events into redis"
  task export_to_redis: [ :environment ] do
    Events::Event.all.find_each { |event| event.export_to_redis }
  end
end