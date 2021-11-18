require 'selenium-webdriver'

class Crawler
    def initialize
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        @driver = Selenium::WebDriver.for :chrome  ,options:options
    end

    def main
        @driver.get('https://www.fujicitio.com/tenpo/index.html')
        
        target_list = @driver.find_elements(:xpath, '//td[@class="tenpo_chiku_box3"]/a')
        p target_list
        target_list.each.with_index do | target, i |
            url = target.attribute('href')
            p i, url
            sleep 1
            @driver.execute_script('window.open()')
            @driver.switch_to.window(@driver.window_handles.last)
            @driver.get(url)
            sleep 1
            name = @driver.find_element(:class, "tenpo_shop_name").text
            address = @driver.find_element(:xpath, '//td[text()="住所"]/following-sibling::td').text
        
            p name, address
            @driver.close
            @driver.switch_to.window(@driver.window_handles.last)
        end
        
        @driver.quit
    end

    def run
        main
    end
end

crawler = Crawler.new
crawler.run
