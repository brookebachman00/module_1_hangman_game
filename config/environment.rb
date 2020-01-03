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

# require 'bundler'
# Bundler.require
# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# require_all 'lib'
# require_all 'app'
# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# Bundler.require

require 'bundler'
require 'rake'
require 'active_record'
Bundler.require
require 'bundler/setup'
require 'sinatra/activerecord'

# Dir[File.join(File.dirname(__FILE__), '../app/models', '*.rb')].each { |f| 
# # puts "Importing file: #{f}"
# require f 
# }
connection_details = YAML.safe_load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
# uncomment line 23 and comment out line 22 in order to show all of the
# SQL queries that Active Record handles.
ActiveRecord::Base.logger = nil
# ActiveRecord::Base.logger = Logger.new(STDOUT)
require_all 'app'