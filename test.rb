require 'open-uri'
require 'nokogiri'

url = "https://www.keiostore.co.jp/business/store_list.html"
res = URI.open(url)
doc = Nokogiri::HTML.parse(res)

doc.xpath('//table[@class="storeList"]//tr/td[contains(@class,"storeName")]/a').each.with_index do |li, i|
    
    url = "https://www.keiostore.co.jp/business/#{li.attribute('href')}"
    name = li.text
    address = li.parent.parent.at_css('.address').text
    tel = li.parent.parent.at_css('.telNum').text
    time = li.parent.parent.at_css('.time').text
    parking = li.parent.parent.at_css('.parking').text

    puts "#{li.parent.parent}"
    #pp "#{url}\n#{name}\n#{address}"
    puts "#{i}:\n#{url}\n#{name}\n#{address}\n#{tel}\n#{time}"
    puts '----'
    
end
