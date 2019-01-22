# frozen_string_literal: true

$:.unshift File.expand_path("./../lib", __FILE__)
require 'views/index'
require 'views/done'
require 'app/scrapper'
require 'bundler'

Bundler.require
Dotenv.load
