set :output, 'log/cron.log'

every 1.minute do
  rake "import:cis_test", :environment => 'development'
end

every 1.day do
  rake "import:cis_test", :environment => 'staging'
end