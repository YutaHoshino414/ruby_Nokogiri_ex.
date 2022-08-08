require 'open-uri'
require 'nokogiri'

url = "https://www.keiostore.co.jp/business/store_list.html"
res = URI.open(url)
doc = Nokogiri::HTML.parse(res)

# 属性値の取得
#https://rooter.jp/web-crawling/nokogiri-method-attr/

doc.xpath('//table[@class="storeList"]//tr/td[contains(@class,"storeName")]/a').each.with_index do |li, i|
    
    p li.class  #Nokogiri::XML::Element
    # how to get attribute? 
    #li.attr('href')
    #li.get_attribute('href')
    #li['href']
    href = li.attribute('href')
    url = "https://www.keiostore.co.jp/business/#{href}"
    p url

    name = li.text
    address = li.parent.parent.at_css('.address').text
    tel = li.parent.parent.at_css('.telNum').text
    time = li.parent.parent.at_css('.time').text
    parking = li.parent.parent.at_css('.parking').text

    
end
