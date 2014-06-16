if defined?(TinyTds)
  TinyTds::Client.setup do |config|
    config.default_query_options hash[:timezone]=:utc  
  end
end
