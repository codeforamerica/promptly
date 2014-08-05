require 'listen'
require 'contra_costa_importer'

# Make sure our blabber gets to Foreman quickly.
$stdout.sync = true

namespace :contra_costa do
  desc "Imports data from Contra Costa County data sources"
  task :import => :environment do
    listener = Listen.to('tmp/data', only: /.csv$/i) do |modified, added, removed|
      added.each do |fresh_path|
        Rails.logger.info "IMPORT: Saw a new file at #{fresh_path}."
        importer = ContraCostaImporter.new(fresh_path)
      end
    end
    listener.start
    Rails.logger.info 'IMPORT: Started listening for new appointment data.'
    sleep
  end
end
