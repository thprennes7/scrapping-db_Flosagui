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

end
