require 'selenium-webdriver'
require 'color_echo'

class Crawler
    def initialize
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        options.add_argument('--window-size=1000,1000')
        @driver = Selenium::WebDriver.for :chrome  ,options:options
    end

    def main
        @driver.get('https://www.cookmart.co.jp/shop')
        sleep 1
        @driver.find_elements(:xpath, '//h2/a').each do | link |
            url = link.attribute('href')
            CE.fg(:blue)
            p url
            @driver.execute_script('window.open()')
            @driver.switch_to.window(@driver.window_handles.last)
            @driver.get(url)
            sleep 1
            name = @driver.find_element(:tag_name, 'h2').text
            info = @driver.find_element(:xpath,'//div[@class="info"]/p').text
            address = info.split(/\n/)[0]
            tel = info.split(/\n/)[1].split(/\u3000/)[0]
            fax = info.split(/\n/)[1].split(/\u3000/)[1]

            CE.fg(:gray)
            p name, address, tel, fax

            @driver.close
            @driver.switch_to.window(@driver.window_handles.last)
        end
    end

    def run
        main
    end
end

crawler = Crawler.new
crawler.run
