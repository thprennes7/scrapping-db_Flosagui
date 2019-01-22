# frozen_string_literal: true

$:.unshift File.expand_path("./../lib", __FILE__)
require 'views/index'
require 'views/done'
require 'app/scrapper'
require 'bundler'
require 'open-uri'
require 'json'

Bundler.require
Dotenv.load

scrapper = Scrapping.new
scrapper.save_as_spreadsheet