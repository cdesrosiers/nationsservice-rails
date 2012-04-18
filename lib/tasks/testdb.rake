namespace :db do

        desc "Seed the test database with base data"
        task seed_testdb: :environment do
            Rake::Task['db:sample:institutions'].invoke
        end
end
