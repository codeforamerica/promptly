set :output, 'log/cron.log'

every 1.minute do
  rake "import_group[CIS_DATABASE_URL,dc_test_calfresh_english,dc_test_calfresh_english]", :environment => 'development'
  rake "import_group[CIS_DATABASE_URL,dc_test_calfresh_span,dc_test_calfresh_spanish]", :environment => 'development'
end