require "selenium-webdriver"
require "capybara"
require "capybara/dsl"

Capybara.default_driver = :selenium_chrome
Capybara.app_host = "https://zaim.net/"
Capybara.default_max_wait_time = 5

module Crawler
  class Zaim
    include Capybara::DSL

    # ログインする
    def login
      visit("https://auth.zaim.net")
      fill_in "data[User][email]",
        :with => ""
      fill_in "data[User][password]",
        :with => ""
      click_button "ログイン"
    end
    
    # 入力履歴の件数を確認する
    def count
      visit("https://zaim.net/money")
      @count = 0
      doc = all(:xpath, '//*[@id="root"]/div/div[2]/div[3]/div[2]/div[2]/div/div')
      doc.each do |i|
        @count += 1
      end
    end

    # 入力履歴を抽出する
    def extraction
      # 入力履歴の件数を表示する
      puts "*********************"
      puts "入力履歴件数：#{@count}"
      puts "*********************"

      # 入力履歴を抽出する
      (1..@count).each do |n|
        puts "====================="
        hiduke = "日付："+find(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[3]").text
        puts hiduke
        category = "カテゴリ："+find(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[4]/span[2]").text
        puts category
        price =  "金額："+find(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[5]").text
        puts price
        shop =  "お店："+find(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[8]").text
        puts shop
        hinmoku = "品目："+find(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[9]").text
        puts hinmoku
        memo = "メモ："+find(:xpath,"//*[@id=\'root\']/div/div[2]/div[3]/div[2]/div[2]/div/div[#{n}]/div[10]").text
        puts memo
        puts "====================="
      end
    end
  end
end

crawler = Crawler::Zaim.new
crawler.login
crawler.count
crawler.extraction
