set :output, 'log/cron.log'

every 1.day, :at => '10:00 am' do
  rake "import_group[dc_waived_calfresh_english,dc_waived_calfresh_english]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_spanish,dc_waived_calfresh_spanish]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_chinese,dc_waived_calfresh_chinese]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_vietnamese,dc_waived_calfresh_vietnamese]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_russian,dc_waived_calfresh_russian]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_tagalog,dc_waived_calfresh_tagalog]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_other,dc_waived_calfresh_other]", :environment => 'production'
  rake "import_group[waived_cases,all_waived_cases]", :environment => 'production'
  rake "import_group[dc_waived_medical,dc_waived_medical]", :environment => 'production'
end

every 2.minutes do
  rake "update_daily_conversations", :environment => 'production'
  runner "Conversation.csv_export_stop_start"
end