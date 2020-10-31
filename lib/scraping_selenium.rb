require "selenium-webdriver"

# ログインページのURL
login_url = 'https://auth.zaim.net'

# 履歴ページのURL
history_url = 'https://zaim.net/money'

# テストアカウント
mail = 'beryu888@gmail.com'
password = 'GidgfRdWofFD'

driver = Selenium::WebDriver.for :chrome

# テストアカウントにログインする
driver.navigate.to login_url
driver.manage.timeouts.implicit_wait = 30

driver.find_element(:name, 'data[User][email]').send_keys(mail)
driver.find_element(:name, 'data[User][password]').send_keys(password)

sleep(3)
driver.find_element(:xpath, '//*[@id="UserLoginForm"]/div[4]/input').click

sleep(2)
# 履歴のページに移動する
driver.navigate.to history_url

sleep(2)

# 過去の入力履歴の件数を確認する
count = 0

doc = driver.find_elements(:xpath, '//*[@id="root"]/div/div[2]/div[3]/div[2]/div[2]/div/div')
doc.each do |i|
  count += 1
end

# 入力履歴の件数を表示する
puts "*********************"
puts "入力履歴件数：#{count}"
puts "*********************"

# 入力履歴を出力する
(1..count).each do |n|

  doc1 = driver.find_elements(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[3]")
  doc1.each do |i|
    puts "====================="
    puts "日付：#{i.text}"
  end

  doc2 = driver.find_elements(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[4]/span[2]")
  doc2.each do |i|
    puts "カテゴリ：#{i.text}"
  end

  doc3 = driver.find_elements(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[5]")
  doc3.each do |i|
    puts "金額：#{i.text}"
  end

  doc4 = driver.find_elements(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[8]")
  doc4.each do |i|
    puts "お店：#{i.text}"
  end

  doc5 = driver.find_elements(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[9]")
  doc5.each do |i|
    puts "品目：#{i.text}"
  end

  doc6 = driver.find_elements(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[10]")
  doc6.each do |i|
    puts "メモ：#{i.text}"
    puts "====================="
  end

end

driver.quit
