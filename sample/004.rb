require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.get('https://www.fujicitio.com/tenpo/index.html')

target_list = driver.find_elements(:xpath, '//td[@class="tenpo_chiku_box3"]/a')
#p target_list
target_list.each.with_index do | target, i |
    url = target.attribute('href')
    p i, url
    sleep 1
    driver.execute_script('window.open()')
    driver.switch_to.window(driver.window_handles.last)
    driver.get(url)
    sleep 1
    name = driver.find_element(:class, "tenpo_shop_name").text
    p name
    driver.close
    driver.switch_to.window(driver.window_handles.last)


end


driver.quit