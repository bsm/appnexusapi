require 'dotenv'
Dotenv.load

Bundler.require
require 'pry'
require 'logger'
require_relative "../lib/appnexusapi"
# load all support files
#Dir["spec/support/**/*.rb"].each { |f| require_relative "../"+f }
def connection
  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO

  AppnexusApi::Connection.new(
    'username' => ENV['APPNEXUS_USERNAME'],
    'password' => ENV['APPNEXUS_PASSWORD'],
    'uri'      => ENV['APPNEXUS_URI'],
    'logger'   => logger
  )
end

