# frozen_string_literal: true

class Scrapping

  def initialize
    city_name = []
    mail = []

    page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

    page.xpath('//a[@class="lientxt"]').each do |row|
      city_name.push(row.text)
      mail.push(Nokogiri::HTML(open('http://annuaire-des-mairies.com' + row['href'].sub('.', ''))).xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text)
    end

    @mail_list = city_name.zip(mail).to_h
  end

  # Méthode qui nous permet de sauvegarder en JSON
  def save_as_json
    # Création du fichier email.JSON dans notre database
    file = File.open("db/email.JSON","w")
    # Conversion de notre hash mail_list en JSON dans le fichier email.JSON
    file.write(@mail_list.to_json)
    # Fermeture du fichier email.JSON
    file.close
  end

  # Méthode qui nous permet de sauvegarder dans un Google Drive tous les noms de Mairies et emails associés
  def save_as_spreadsheet
    # Configuration de notre fichier
    session = GoogleDrive::Session.from_config("config.json")
    # Ouverture de la feuille 1 de notre Spreadsheet
    ws = session.spreadsheet_by_key("1epRxZFV07u3vgZDgUyexrR3SeUKxJp8e50rzfY2U6o4").worksheets[0]

    # Cellule A1 = Mairie, Cellule B1 = Email
    ws[1, 1] = "Mairie"
    ws[1, 2] = "Email"
    # Lancement d'une boucle qui intègre les noms des mairies dans la colonne A, et emails dans la colonne B
    @mail_list.each_with_index do |(name, mail), index|
      ws[index + 2, 1] = name
      ws[index + 2, 2] = mail
    end
    # Sauvegarde du ws
    ws.save
  end

  # Méthode qui nous permet de sauvegarder en CSV
  def save_as_csv
    # Création d'un fichier email.csv dans notre data base.
    csv = CSV.open("db/email.csv", "w")
    csv << ["Index", "Mairie", "Mail"]
    # On crée une boucle qui nous permet d'intégrer chaque mairie et email dans notre CSV
    @mail_list.each_with_index do |(name, mail), index|
      csv << [index, name, mail]
    end
  end
end
