require 'open-uri'
require 'nokogiri'
require 'kconv'

# サイトの<meta charset> がおかしい？文字化け
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
end

# サイトの<meta charset> がおかしい？文字化け 
# https://qiita.com/foloinfo/items/435f0409a6e33929ef3c
# こちらの「追記3」を参考にしたところ、文字化け解消
url_list.each.with_index do |url, i|
    res = open(url, "r:binary").read
    doc = Nokogiri::HTML.parse(res.toutf8, nil, 'utf-8')
    name = doc.at_css('.tenpo_shop_name')
    puts name
    sleep(1)
end