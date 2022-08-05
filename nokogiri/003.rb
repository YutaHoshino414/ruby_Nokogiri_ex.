require 'open-uri'
require 'nokogiri'

url = "https://www.cookmart.co.jp/shop"
res = URI.open(url)
doc = Nokogiri::HTML.parse(res)

doc.xpath('//h2/a').each.with_index do |link, i|
    url = link.attribute('href')
    puts '----'
    puts url
    puts link.text
end