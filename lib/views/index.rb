# frozen_string_literal: true

class Index

  def initialize
    # On crée une instance prompt de classe tty-prompt pour le menu et une instance scrapper de classe Scrapping pour effectuer nos exports
    prompt = TTY::Prompt.new
    scrapper = Scrapping.new

    # On appel le menu et à chaque réponse on assigne une action de l'instance scrapper
    prompt.select("Choose where you want to save your scrapp", cycle: true) do |menu|
      menu.choice 'JSON', -> { scrapper.save_as_json }
      menu.choice 'Spreadsheet', -> { scrapper.save_as_spreadsheet }
      menu.choice 'CSV', -> { scrapper.save_as_csv }
    end
  end
end
