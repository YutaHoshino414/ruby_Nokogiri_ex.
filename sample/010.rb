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
        @driver.get('@@@@')
        
    end

    def run
        main
    end
end

crawler = Crawler.new
crawler.run