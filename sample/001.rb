require 'open-uri'
require 'nokogiri'

url = "https://www.fujicitio.com/tenpo/index.html"
res = URI.open(url)
doc = Nokogiri::HTML.parse(res)

url_list = []
doc.xpath('//td[@class="tenpo_chiku_box3"]/a').each.with_index do |td, i|
    a = td.attribute('href').text.gsub(/^./, '')
    url = "https://www.fujicitio.com/tenpo#{a}"
    #puts a
    puts url
    puts '----'
    sleep(1)
    url_list.push(url)
    #res = URI.open(url)
    #page = Nokogiri::HTML.parse(res)
    #name = page.at_css('.tenpo_shop_name')
    #puts name
end
url_list.each.with_index do |url, i|
    res = URI.open(url)
    doc = Nokogiri::HTML.parse(res)
    name = doc.at_css('.tenpo_shop_name')
    puts name
    sleep(1)
end