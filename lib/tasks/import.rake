#add arguments (http://stackoverflow.com/questions/825748/how-do-i-pass-command-line-arguments-to-a-rake-task)
desc "Import group from external datasource"
task :import_group, [:table, :group_name_id] => :environment do |t, args|
  table = args[:table]
  group_name_id = args[:group_name_id]
  
  puts "#{Time.now.to_formatted_s} - Running rake import_group[#{table},#{group_name_id}"
  ImportHelper.update_or_create_group_from_db_table(table, group_name_id)
end