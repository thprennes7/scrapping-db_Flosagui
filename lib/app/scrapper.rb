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

  def save_as_json
    file = File.open("db/email.JSON","w")
    file.write(@mail_list.to_json)
    file.close
  end

  def save_as_spreadsheet
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1epRxZFV07u3vgZDgUyexrR3SeUKxJp8e50rzfY2U6o4").worksheets[0]

    ws[1, 1] = "Mairie"
    ws[1, 2] = "Email"
    @mail_list.each_with_index do |(name, mail), index|
      ws[index + 2, 1] = name
      ws[index + 2, 2] = mail
    end
    ws.save
  end
end
