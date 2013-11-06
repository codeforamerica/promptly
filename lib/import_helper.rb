class ImportHelper < ActiveRecord::Base
  
  def self.update_or_create_group_from_db_table(table, group_name_id)
    now = DateTime.now.to_s(:date_format)  
    puts "Starting import from table:#{table} to group:#{group_name_id}"
    Rails.logger.info("#Starting group import at #{now}
      Group: #{group_name_id}
      From table: #{table}")

    # Check for table
    puts "Checking for table..."
    con = connection()
    if !con.tables.include? table
      msg = "Table not found: #{table}"
      Rails.logger.error(msg)
      raise msg
    end
    
    # Query table
    puts "Querying DB..."
    result = con.select_all("SELECT * FROM #{table}")

    # Find phone key or log
    phone_keys = ["phone", "Phone", "PHONE", "phone_number", "phone number"]
    result_keys = result.first.keys
    key = (phone_keys & result_keys).first
    unless key
      msg = "No phone number column found. Make sure the table has one of these columns: #{phone_keys}"
      Rails.logger.error(msg)
      raise msg
    end

    # Creat phone # array
    phone_numbers = []
    result.each do |p_hash|
      val = p_hash[key]
      phone_numbers << val
    end
    
    # Remove duplicates, nils
    phone_numbers = phone_numbers.uniq.compact

    # Find or create group
    puts "Finding/creating group"
    g = Group.where(group_name_id: group_name_id).first_or_create(
      :group_name_id => group_name_id,
      :name => group_name_id,
      :editable => 0
      )
    g.update_attributes(:description => "Imported #{phone_numbers.count} phone numbers from #{table} at #{now}.")
    g.save
    
    # Save phone numbers to group
    puts "Modifying group: #{g.group_name_id}, #{g.id}"
    puts "Adding phone numbers: #{phone_numbers}"
    g.recipients.clear
    Group.add_phone_numbers_to_group(phone_numbers, g)

    puts "Finished group import..."
    Rails.logger.info("Finished group import {now}
      Group: #{group_name_id}
      From table: #{table}")
  end
end
