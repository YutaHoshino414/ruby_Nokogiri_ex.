require 'selenium-webdriver'
require 'color_echo'

class Crawler
    def initialize
        options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        options.add_argument('--window-size=1000,1000')
        @driver = Selenium::WebDriver.for :chrome  ,options:options
    end

    def main
        @driver.get('https://www.curves.co.jp/search/')
        target_list = @driver.find_elements(:xpath, '//map/area')
        target_list.each do | target |
            url = target.attribute('href')
            p url
            
        end
        
    end

    def run
        main
    end
end

crawler = Crawler.new
crawler.run