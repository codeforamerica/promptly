class ImportHelper < ActiveRecord::Base
  
  def self.update_or_create_group_from_db_table(db_url = "", table, group_name_id)
    puts "#{Time.now.to_formatted_s} - STARTING GROUP IMPORT
    Group: #{group_name_id}
    From DB: #{db_url}
    From table: #{table}"
    
    #connect to DB
    # puts "Connecting to external source."
    # establish_connection(ENV[db_url])
    con = connection()

    #get SQL result
    puts "Querying DB."
    sql = "SELECT * FROM #{table}"
    result = con.select_all(sql)

    #reconnect to rails DB
    # puts "Reconnecting to rails DB."
    # remove_connection
    # establish_connection(ENV['DATABASE_URL'])

    #save as array of phone number
    puts "Converting phone numbers to array."
    phone_numbers = []
    phone_key = ""
    test_keys = ["phone", "phone_number", "phone number", "number", "contact"]
    test_keys.each do |key|
      if result.first.keys.include?(key)
        phone_key = key
        puts "Found a phone_key: #{phone_key}"
      end
    end
    result.each do |p_hash|
      val = p_hash[phone_key]
      if val
        phone_numbers << val
      end
    end

    # Find or create group
    g = Group.where(group_name_id: group_name_id).first_or_create(
      :group_name_id => group_name_id,
      :name => group_name_id,
      :description => "Imported from #{table}",
      :editable => 0
      )
    g.save
    puts "Modifying group: #{g.group_name_id}, #{g.id}"

    g.recipients.clear
    puts "removing existing recipients from group"

    # Save phone numbers to group
    puts "Adding phone numbers: #{phone_numbers}"
    g.add_phone_numbers(phone_numbers)
    puts "#{Time.now.to_formatted_s} - FINISHED GROUP IMPORT"
  end
end