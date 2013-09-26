set :output, 'log/cron.log'

every 1.hour do
  rake "import_group[dc_waived_calfresh_english,dc_waived_calfresh_english]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_spanish,dc_waived_calfresh_spanish]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_chinese,dc_waived_calfresh_chinese]", :environment => 'production'
end