require 'open-uri'
require 'nokogiri'

url = "@@@@@"
res = URI.open(url)
doc = Nokogiri::HTML.parse(res)

doc.xpath('¥¥¥¥¥¥¥').each.with_index do |li, i|
    
    puts '----'
    
end