require 'selenium-webdriver'
require 'json'
require 'pry'
require 'open-uri'
require 'fileutils'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--ignore-certificate-errors')
options.add_argument('--disable-popup-blocking')
options.add_argument('--disable-translate')
options.add_argument("--window-size=1920,1080")
# options.add_argument('--headless')
driver = Selenium::WebDriver.for :chrome, options: options

restaurant_name = "三奇壹號咖啡館x築甜製菓"
driver.navigate.to "http://maps.google.com/?q=#{restaurant_name}"

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

# 等待前 20 張菜單相片的 elements 讀取完成
menu_photo_divs = []
wait.until do
  menu_photo_divs = driver.find_elements(:xpath, '//a[@data-photo-index]/div[1]/div[1]')
  menu_photo_divs.length == 20
end

# 建立商家的相片目錄
photo_dir = 'photos'
response = FileUtils.mkdir_p("#{photo_dir}/#{restaurant_name}")
puts "photo directory for the restaurant successfully created: #{response}"

# 儲存菜單相片
menu_photo_divs.each do |photo_div|
  driver.action.move_to(photo_div).perform
  photo_div_style = photo_div.attribute('style')

  start_point = 'https'
  url_start_index = photo_div_style.index(start_point)
  start_index = url_start_index > -1 ? url_start_index : 0
  photo_url = photo_div_style[start_index...photo_div_style.index('");')]
  photo_name = "#{photo_dir}/#{restaurant_name}/#{photo_url.split('/').last}.jpg"
  File.open(photo_name, 'wb') do |f|
    puts "photo url: #{photo_url}"
    f.write URI.open(photo_url).read
    puts "photo successfully downloaded: #{photo_name}"
  end
end
