class ImportHelper < ActiveRecord::Base
  
  def self.load_deliveries_from_db_table(db_url, table)
    #connect to DB
    puts "Connecting to DB..."
    establish_connection(ENV[db_url])
    con = connection()

    #get SQL result
    sql = "SELECT * FROM #{table}"
    result = con.select_all(sql)

    #reconnect to rails DB
    remove_connection
    establish_connection(ENV['DATABASE_URL'])

    #export csv
    filepath = "app/imports/#{table}_lastimport.csv"
    CSV.open("#{filepath}", "wb") do |csv|
      csv << result.first.keys # headers
      result.each do |hash|
        csv << hash.values
      end
    end

    #import csv
    delivery_import = DeliveryImport.new
    delivery_import.load_deliveries_from_csv(filepath)
  end
end