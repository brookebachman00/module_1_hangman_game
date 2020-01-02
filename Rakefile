require "active_record"
require "sinatra/activerecord/rake"
require_relative "config/environment.rb"

task :environment do
  ENV["ACTIVE_RECORD_ENV"] ||= "development"
  require_relative "./config/environment"
end

task :console => :environment do
  Pry.start
end