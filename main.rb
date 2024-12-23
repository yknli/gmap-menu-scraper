require 'selenium-webdriver'
require 'json'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--ignore-certificate-errors')
options.add_argument('--disable-popup-blocking')
options.add_argument('--disable-translate')
options.add_argument("--window-size=1920,1080")
# options.add_argument('--headless')
driver = Selenium::WebDriver.for :chrome, options: options

driver.navigate.to "https://www.google.com.tw/maps/place/%E4%B8%89%E5%A5%87%E5%A3%B9%E8%99%9F%E5%92%96%E5%95%A1%E9%A4%A8x%E7%AF%89%E7%94%9C%E8%A3%BD%E8%8F%93:Keelung+Senki+Coffee/@25.1290489,121.7399404,17z/data=!3m2!4b1!5s0x345d4e3e26c83a93:0xd80e825e7bcdbedb!4m6!3m5!1s0x345d4e3e27183e03:0xc14a07f92a0fee8d!8m2!3d25.1290489!4d121.7425207!16s%2Fg%2F11f5q0btsy?hl=zh-TW&entry=ttu&g_ep=EgoyMDI0MTIxMS4wIKXMDSoASAFQAw%3D%3D"

wait = Selenium::WebDriver::Wait.new(timeout: 10)
menu_button = nil
wait.until do
  menu_button = driver.find_element(:xpath, '//button[@aria-label="菜單"]')
  # menu_button = driver.find_element(:xpath, '//h2[contains(string(), "相片和影片")]')
  menu_button.displayed?
end

puts menu_button.attribute('aria-label')

driver.action.
  move_to_location(200, 200).
  pause(duration: 1).
  perform

driver.execute_script("arguments[0].scrollIntoView(true);" , menu_button)
driver.action.click.pause(duration: 1).perform
menu_tab_button = driver.find_element(:xpath, '//div[contains(string(), "菜單")]/ancestor::button[1]')
puts menu_tab_button.tag_name

driver.action.
  move_to(menu_tab_button).
  pause(duration: 1).
  click.
  pause(duration: 1).
  perform