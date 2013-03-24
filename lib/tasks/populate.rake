namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'factory_girl_rails'
    require 'database_cleaner'

    puts 'Deleting all records from all tables'
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    User.with_deleted.all.each { |u| u.destroy! }

    puts 'Running db:seed'
    Rake::Task["db:seed"].execute

    # puts 'Generating test data. This might take a while...'
    # puts 'Generating brands...'
    # FactoryGirl.create_list :brand, 10
    # # puts 'Generating product_categories...'
    # # FactoryGirl.create_list :product_category_leaf, 5
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
