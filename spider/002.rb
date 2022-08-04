require "kimurai"


class TestSpider < Kimurai::Base
    @name = "kimurai_spider"
    @engine = :selenium_chrome  
    @start_urls = ["https://www.fujicitio.com/tenpo/index.html"] #Fuji Supermarket
    @config = {
        user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
        before_request: { delay: 2 }
    }

    def parse(response, url:, data: {})
        urls = []
        response.css("td.tenpo_chiku_box3 a").each do |tenpo|
            tenpo_url = absolute_url(tenpo[:href], base: url)
            p tenpo_url
            urls << tenpo_url
        end

        # thread処理
        in_parallel( :parse_tenpo, urls, threads: 3)
    end

    def parse_tenpo(response, url:, data: {})
        items = {}
        # try xpath
        items[:name] = response.xpath('//td[@class="tenpo_shop_name"]').text
        items[:address] = response.xpath('//td[text()="住所"]/following-sibling::td').text
        items[:tel] = response.xpath('//td[text()="電話番号"]/following-sibling::td').text
        items[:url] = url

        filename = File.basename(__FILE__).gsub(/.rb/,'')
        save_to "./datas/results_#{filename}.json", items, format: :pretty_json
        # try [format:jsonlines]
        #save_to "results_jl.jl", items, format: :jsonlines
    end
end

TestSpider.crawl!