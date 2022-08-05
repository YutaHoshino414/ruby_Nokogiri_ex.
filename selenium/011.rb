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
        @driver.get('https://www.dandadan.jp/shop/')
        
    end

    #def output_csv
    #    CSV.open("list_#{File.basename(__FILE__).gsub(/.rb/,'')}.csv", "w") do |f|
    #        f << ['name']
    #        @datas.each do |tenpo|
    #            f << tenpo
    #        end
    #    end
    #end

    def run
        main
        #output_csv
    end
end


crawler = Crawler.new
crawler.run
