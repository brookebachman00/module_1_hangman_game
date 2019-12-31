# require "bundler/setup"
# require "sinatra/activerecord"
# require "ostruct"
# require "date"
# require "rake"
# require "concurrent"
# require 'require_all'
# require_all 'app/models'
# Bundler.require

# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/hangman.db')
# require_all 'lib'

# # connection_details = YAML::load(File.open('config/database.yml'))
# # ActiveRecord::Base.establish_connection(connection_details)

require 'bundler'
Bundler.require
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/hangman.db')
require_all 'lib'