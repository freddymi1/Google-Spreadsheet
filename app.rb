
require 'bundler'

require_relative "lib/scrapper.rb"
Bundler.require

$:.unshift File.expand_path("../../lib", __FILE__)

url = Scrapper.new("Ville", "Email")
url.generateFile
puts url.generate_spreadsheet