# frozen_string_literal: true

$:.unshift File.expand_path("./../lib", __FILE__)

# On déclare toutes les dépendances dont on a besoin dans notre programme
require 'views/index'
require 'views/done'
require 'app/scrapper'
require 'bundler'
require 'open-uri'
require 'json'
require 'csv'

# On installe nos gems 
Bundler.require
Dotenv.load

# On crée nos objets 
index = Index.new
done = Done.new