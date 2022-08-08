require "kimurai"


class TestSpider < Kimurai::Base
    @name = "kimurai_spider"
    @engine = :selenium_chrome  
    @start_urls = ["https://search.travel.rakuten.co.jp/ds/undated/search?f_dai=japan&f_sort=hotel&f_page=1&f_hyoji=30&f_tab=hotel&f_chu=aomori&f_cd=02"] 
    @config = {
        user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
        before_request: { delay: 2 }
    }

    def parse(response, url:, data: {})
        response.css('select[id="dh-middle"] option').each do |pref|
            pref_url = "https://search.travel.rakuten.co.jp/ds/undated/search?f_dai=japan&f_sort=hotel&f_hyoji=30&f_tab=hotel&f_chu=#{pref['value']}&f_cd=02" 
            request_to :page_parse, url: pref_url
        end
        
    end

    def page_parse(response, url:, data: {})
        result = response.css('p.pagingTitle span em')[0].text.to_f #float型
        pages = (result / 100).ceil    #切り上げ
        p "------------"
        p result
        p pages
        p "------------"
        pages.times do |page|
            page_url = "#{url}&f_page=#{page+1}"
            request_to :pref_parse, url: page_url
        end
    end

    def pref_parse(response, url:, data: {})
        p url
        filename = File.basename(__FILE__).gsub(/.rb/,'')
        data = {}
        response.css('div.info h1 a').each do |tenpo|
            tenpo_name = tenpo.text
            tenpo_url = tenpo["href"]
            data['name'] = tenpo_name
            data['url'] = tenpo_url
            
            save_to "./datas/results_#{filename}.csv", data, format: :csv
        end
    end 

end

TestSpider.crawl!