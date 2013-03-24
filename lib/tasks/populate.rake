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
    puts 'Generating sports...'
    FactoryGirl.create_list :sport, 5
    puts 'Generating tournaments...'
    FactoryGirl.create_list :tournament, 2, :sport_id => Sport.find(rand(Sport.count-1) + 1).id, :format_id => Format.find(rand(Format.count-1) + 1).id
    puts 'Generating locations...'
    FactoryGirl.create_list :location, 5
    puts 'Generating matches...'
    FactoryGirl.create_list :match, 5, tournament_id: Tournament.first.id
    puts 'Generating highlights...'
    FactoryGirl.create_list :highlight, 2, sport_id: Sport.first.id
  end
end