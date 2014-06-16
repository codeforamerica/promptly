if defined?(TinyTds)
  TinyTds::Client.default_query_options hash[:timezone]=:utc
end
