#add arguments (http://stackoverflow.com/questions/825748/how-do-i-pass-command-line-arguments-to-a-rake-task)
desc "Import group from external datasource"
task :import_group, [:db_url, :table, :group_name_id] => :environment do |t, args|
  db_url = args[:db_url]
  table = args[:table]
  group_name_id = args[:group_name_id]
  
  puts "#{Time.now.to_formatted_s} - Running rake import_group[#{db_url},#{table},#{group_name_id}"
  ImportHelper.update_or_create_group_from_db_table(db_url, table, group_name_id)
end