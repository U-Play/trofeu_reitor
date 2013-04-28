namespace :db do
  desc "Drop, Create, Migrate and Populate"
  task :my_reset => :environment do
    puts 'Running db:drop'
    Rake::Task["db:drop"].execute
    puts 'Running db:create'
    Rake::Task["db:create"].execute
    puts 'Running db:migrate'
    Rake::Task["db:migrate"].execute
    puts 'Running db:populate'
    Rake::Task["db:populate"].execute
  end
end
