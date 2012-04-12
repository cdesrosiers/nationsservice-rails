require 'nokogiri'

namespace :db do
  
  desc "Fill database with sample data"
  namespace :sample do
    
    desc "Fill database with sample users"
    task users: :environment do
      puts "Adding sample users to database..."
      load "#{File.dirname(__FILE__)}/users.rb"
      puts "done"
    end
    
    desc "Fill database with institutions"
    task institutions: :environment do
      puts "Adding institutions to database..."
      load "#{File.dirname(__FILE__)}/institutions.rb"
      puts "done"
    end
    
    desc "Fill database with positions"
    task positions: :environment do
      puts "Adding sample positions to database..."
      load "#{File.dirname(__FILE__)}/positions.rb"
      puts "done"
    end
    
    desc "Fill database with sample data"
    task fill: [:institutions, :users, :positions]
  end
end