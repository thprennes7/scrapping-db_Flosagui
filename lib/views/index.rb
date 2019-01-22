# frozen_string_literal: true

class Index

  def initialize
    prompt = TTY::Prompt.new
    scrapper = Scrapping.new

    prompt.select("Choose where you want to save your scrapp") do |menu|
      menu.choice 'JSON', scrapper.save_as_json
      menu.choice 'Spreadsheet', scrapper.save_as_spreadsheet
      menu.choice 'CSV', scrapper.save_as_csv
    end      
  end
end