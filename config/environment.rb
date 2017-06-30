require 'bundler/setup'
Bundler.require


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/dogs.sqlite"
)

require_relative "../app/controllers/application_controller.rb"

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].sort.each {|f| require f}
