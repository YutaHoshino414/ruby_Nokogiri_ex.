require 'open-uri'
require 'nokogiri'

url = "https://www.fujicitio.com/tenpo/shop_74.html"
res = URI.open(url)
charset = res.charset
doc = Nokogiri::HTML.parse(res, charset)

puts doc