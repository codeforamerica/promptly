require 'listen'
require 'lib/contra_costa_importer.rb'

$stdout.sync = true

def wrangle(path)
  importer = ContraCostaImporter.new(path)
end

listener = Listen.to('tmp', debug: true) do |modified, added, removed|
  puts "Added: #{added.first}"
  wrangle(added.first)
  # added.each do |fresh_path|
  #   puts "Saw a new file at #{fresh_path}."
  #   importer = ContraCostaImporter.new(fresh_path)
  # end
end
listener.start
puts 'Started listening for new appointment data.'
sleep
