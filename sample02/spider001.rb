require "kimurai"


class TestSpider < Kimurai::Base
    @name = "kimurai_spider"
    @engine = :selenium_chrome  
    @start_urls = ["https://www.fujicitio.com/tenpo/index.html"] 
    @config = {
        # ユーザーエージェント
        user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
        before_request: { delay: 2 }
    }

    def parse(response, url:, data: {})
        response.css("td.tenpo_chiku_box3 a").each do |tenpo|
            p tenpo.text
        end
    end
end

TestSpider.crawl!