namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'factory_girl_rails'
    require 'database_cleaner'

    puts 'Deleting all records from all tables'
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    # User.with_deleted.all.each { |u| u.destroy! }

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
    # puts 'Generating shipment_conditions...'
    # FactoryGirl.create_list :shipment_condition, 5
    # puts 'Generating prototypes with properties and variant_properties...'
    # FactoryGirl.create_list :prototype_with_properties_and_variant_properties, 5
    # puts 'Generating products with variants...'
    # FactoryGirl.create_list :product_full, 5, :brand_id => PZS::Brand.find(rand(PZS::Brand.count-1)+1).id
    # puts 'Generating carts with new user'
    # FactoryGirl.create_list :cart, 2
    # puts 'Generating addresses'
    # FactoryGirl.create_list :address, 5
    # puts 'Generating admin user'
    # FactoryGirl.create :admin, email: "admin@gmail.com", password: "asdasd", password_confirmation: "asdasd"
    # puts 'Generating user'
    # FactoryGirl.create :user_with_user_role, email: "user@gmail.com", password: "asdasd", password_confirmation: "asdasd"
  end
end
