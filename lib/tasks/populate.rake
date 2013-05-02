namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'factory_girl_rails'
    require 'database_cleaner'

    puts 'Deleting all records from all tables'
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    puts 'Running db:seed'
    Rake::Task["db:seed"].execute

    puts 'Generating test data. This might take a while...'
    puts 'Generating locations...'
    FactoryGirl.create_list :location, 5
    puts 'Generating tournament...'
    FactoryGirl.create :tournament, :sport_id => Sport.find_by_name('Futsal M').id,
                       :format_id => Format.last.id, :event_id => Event.first.id
    puts 'Generating match...'
    FactoryGirl.create :ronaldo_messi, tournament_id: Tournament.first.id, format: Format.first
  end
end
