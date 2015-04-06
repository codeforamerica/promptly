set :output, 'log/cron.log'

every 1.day, :at => '10:00 am' do
  rake "import_group[dc_waived_calfresh_english,dc_waived_calfresh_english, 1]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_spanish,dc_waived_calfresh_spanish, 1]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_chinese,dc_waived_calfresh_chinese, 1]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_vietnamese,dc_waived_calfresh_vietnamese, 1]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_russian,dc_waived_calfresh_russian, 1]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_tagalog,dc_waived_calfresh_tagalog, 1]", :environment => 'production'
  rake "import_group[dc_waived_calfresh_other,dc_waived_calfresh_other, 1]", :environment => 'production'
  rake "import_group[waived_cases,all_waived_cases, 1]", :environment => 'production'
  rake "import_group[dc_waived_medical,dc_waived_medical, 1]", :environment => 'production'
end

every 2.minutes do
  rake "update_daily_conversations", :environment => 'production'
end

every :monday, :at => '8am' do
  runner "Conversation.csv_export_stop_start"
end