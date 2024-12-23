require 'selenium-webdriver'
require 'json'
require 'pry'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--ignore-certificate-errors')
options.add_argument('--disable-popup-blocking')
options.add_argument('--disable-translate')
options.add_argument("--window-size=1920,1080")
# options.add_argument('--headless')
driver = Selenium::WebDriver.for :chrome, options: options

driver.navigate.to "https://www.google.com.tw/maps/place/%E4%B8%89%E5%A5%87%E5%A3%B9%E8%99%9F%E5%92%96%E5%95%A1%E9%A4%A8x%E7%AF%89%E7%94%9C%E8%A3%BD%E8%8F%93:Keelung+Senki+Coffee/@25.1290489,121.7399404,17z/data=!3m2!4b1!5s0x345d4e3e26c83a93:0xd80e825e7bcdbedb!4m6!3m5!1s0x345d4e3e27183e03:0xc14a07f92a0fee8d!8m2!3d25.1290489!4d121.7425207!16s%2Fg%2F11f5q0btsy?hl=zh-TW&entry=ttu&g_ep=EgoyMDI0MTIxMS4wIKXMDSoASAFQAw%3D%3D"

# 找到 "相片和影片" header
photos_n_videos_header = driver.find_element(:xpath, '//h2[contains(string(), "相片和影片")]')

# 捲動畫面到 "相片和影片" header
driver.execute_script("arguments[0].scrollIntoView(true);" , photos_n_videos_header)

# 點選向右箭頭
next_button = driver.find_element(:xpath, '//button[@aria-label="下一張相片"]')
driver.execute_script("arguments[0].click();" , next_button)

# 點選 "菜單"
wait = Selenium::WebDriver::Wait.new(timeout: 10)
menu_button = nil
wait.until do
  menu_button = driver.find_element(:xpath, '//button[@aria-label="菜單"]/img')
  menu_button.displayed?
end

menu_button.click

menu_photo_divs = []
wait.until do
  menu_photo_divs = driver.find_elements(:xpath, '//a[@data-photo-index]/div[1]/div[1]')
  puts menu_photo_divs[19].attribute('style') if menu_photo_divs[19] != nil
  menu_photo_divs.length == 20
end
puts menu_photo_divs.length

# binding.pry
menu_photo_divs.map do |photo_div|
  driver.action.move_to(photo_div).perform
  photo_div_style = photo_div.attribute('style')

  start_point = 'https'
  url_start_index = photo_div_style.index(start_point)
  start_index = url_start_index > -1 ? url_start_index : 0
  photo_url = photo_div_style[start_index...photo_div_style.index('");')]
  puts photo_url
  photo_url
end

puts menu_photo_divs.length
