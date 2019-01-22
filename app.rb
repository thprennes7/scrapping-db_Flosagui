# frozen_string_literal: true

$:.unshift File.expand_path("./../lib", __FILE__)
require 'views/index'
require 'views/done'
require 'app/scrapper'
require 'bundler'
require 'open-uri'
require 'json'
require 'csv'

Bundler.require
Dotenv.load

index = Index.new
done = Done.new