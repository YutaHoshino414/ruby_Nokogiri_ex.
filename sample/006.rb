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
        @driver.get('https://www.matsuyafoods.co.jp/shop/matsuken_ch/')
        sleep 1
        link_list = @driver.find_elements(:xpath, '//ul[@class="links-shop"]/li/a')
        link_list.slice(0..4).each do | link |
            url = link.attribute('href')
            CE.fg(:magenta)
            p url
            @driver.execute_script('window.open()')
            @driver.switch_to.window(@driver.window_handles.last)
            @driver.get(url)
            name = @driver.find_element(:tag_name, 'h3').text
            address = @driver.find_element(:class, 'address').text
            tel = @driver.find_element(:class, 'tel').text
            hour = @driver.find_element(:class, 'time').text.gsub(/（.*）/,'')

            CE.fg(:gray)
            p name,address,tel,hour,'---'

            tenpo_list.append([name,url])
            @driver.close
            @driver.switch_to.window(@driver.window_handles.last)
        end
        CE.fg(:green)
        p tenpo_list
        @datas = tenpo_list
    end

    def output_csv
        CSV.open("list_006.csv", "w") do |f|
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