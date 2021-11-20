require 'selenium-webdriver'
require 'color_echo'
require 'csv'

class Crawler
    def initialize
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        options.add_argument('--window-size=1000,1000')
        @driver = Selenium::WebDriver.for :chrome  ,options:options
    end

    def main
        tenpo_list = []
        @driver.get('http://www.lifecorp.jp/store/syuto/index.html')
        sleep 1
        target = @driver.find_elements(:xpath,'//td[@class="tw-1"]/span/a')
        target.slice(0..82).each.with_index do |t, i|
            name = t.text
            url = t.attribute('href')
            p i, url, name
            sleep 1
            tenpo_list.append([name,url])
        end
        p tenpo_list
        @datas = tenpo_list
    end

    def output_csv
        CSV.open("list_#{File.basename(__FILE__).gsub(/.rb/,'')}.csv", "w") do |f|
            f << ['name','url']
            @datas.each do |tenpo|
                f << tenpo
            end
        end
    end

    def run
        main
        output_csv
    end
end

crawler = Crawler.new
crawler.run