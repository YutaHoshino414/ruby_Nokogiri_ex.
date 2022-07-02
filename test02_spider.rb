require "kimurai"

class TestSpider < Kimurai::Base
    @name = "kimurai_spider"
    @engine = :selenium_chrome  # スクレイピングに使用するドライバ
    @start_urls = ["https://cyclemarket.jp"] # 最初に訪れるURL。配列で複数設定することも可能。
    @config = {
        # ユーザーエージェント
        user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
        before_request: { delay: 2 }
    }

    def parse(response, url:, data: {})
        # CSSセレクタを使ってヘッダのナビゲーションを取得
        # 項目の取得には「css」や「xpath」といったNokogiriの検索系メソッドが使用できる
        response.css("#nav-global ul li a").each do |menu|
            # skip if :
            next if menu[:class].include?("outlet") || menu[:class].include?("parts")
            # navから各urlを取得
            category_name = menu.css("span.caption").text
            category_url = absolute_url(menu[:href], base: url)
    
            request_to :parse_category_page, url: category_url, data: { category_name: category_name }
        end
    end

    def parse_category_page(response, url:, data: {})
        # 商品情報を取得する
        response.css("#cy-products .cy-product-list .product a").each do |product|
            # CSV出力のために1件ごとにハッシュに入れる
            row = {}
            row[:name] = product_name(product.css(".body .title").text.strip)
            row[:category_name] = data[:category_name]
            row[:price_non_tax] = product.css(".price__nonTax").text.strip.delete("^0-9")
            row[:price_in_tax] = product.css(".price__inTax").text.strip.delete("^0-9")
    
            # CSVファイルに出力する
            save_to "results.csv", row, format: :csv
        end
    end

    private

    # 商品名にメーカー名がついている場合はメーカー名を取り除く
    def product_name(base_name)
        base_name.include?("\n") ? base_name.split("\n")[1].strip : base_name
    end

end

TestSpider.crawl!
