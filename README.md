# scraping

## 環境・主要Gem
* ruby 2.6.5
* selenium-webdriver
* capybara

## ファイルの構成
```
zaim_scraping
├── Gemfile
├── Gemfile.lock
├── lib
│   └── scraping.rb (selenium-webdriver + capybara)
│   └── scraping_selenium.rb (selenium-webdriver のみ)
│   └── scraping_for_test.rb (「scraping.rb」と同じ内容ですが、テスト用に一部をコメントアウトしています。)
└── test
    └── scraping_test.rb
```

## 動作確認方法

任意のディレクトリに本リポジトリをクローンしてください。
```
git clone git@github.com:beryu77/zaim_scraping.git
```

Gemのインストール
```
bundle install
```

### chrome driverのダウンロード/パスを通す

ファイルのダウンロード
http://chromedriver.storage.googleapis.com/index.html

ファイルの移動
```
sudo mv ['解凍したchromedriver'] /usr/local/bin
```

パスを通す
```
export PATH="/usr/local/bin:$PATH"
```

### スクレイピングの実行

今回の課題では２つのタイプのツールを開発しました。

「scraping.rb」 は 「selenium-webdriver + capybara」を用いているのに対して、「scraping_selenium.rb」 は 「selenium-webdriver」のみでコードを書いています。

```
ruby lib/scraping.rb
```
```
ruby lib/scraping_selenium.rb
```
### テストの実行
テストは「scraping_for_test.rb」を対象としています。

「scraping_for_test.rb」は「scraping.rb」と同じ内容ですが、テストのために一部をコメントアウトしています。

```
ruby test/scraping_test.rb
```

## 開発にかかった時間
合計時間：約33時間

内訳</br>
学習：約10時間</br>
ツール開発：約8時間</br>
テスト検討：約15時間

## 工夫した点

### 開発過程
最初は「open-url」、「nokogiri」、「Mechanize」を用いて開発をしていましたが、ログイン処理が上手く行きませんでした。</br>
JavaScriptの影響であると判断し、ブラウザを起動して操作する方向で改めて検討し、「selenium-webdriver」を用いて開発しました。</br>
「selenium-webdriver」のみでも入力履歴を表示することができましたが、Rspecで馴染みがあり、コード自体も感覚的にわかりやすい「capybara」を用いた方法があることを知り、「selenium-webdriver + capybara」でも開発してみました。</br>

### 工夫した箇所（苦戦した箇所）
今回のツール開発で苦戦した箇所は、入力履歴の件数を取得することでした。</br>
入力履歴の件数さえ取得してしまえば、あとはeach文でなんとかできるだろうと考えたものの、実現するまでにしばらく時間を要しました。

[scraping.rb]
```
# 入力履歴の件数を確認する
    def count
      visit("https://zaim.net/money")
      @count = 0
      doc = all(:xpath, '//*[@id="root"]/div/div[2]/div[3]/div[2]/div[2]/div/div')
      doc.each do |i|
        @count += 1
      end
    end
```

### テストコードについて
ツールの開発自体は勉強しながらも楽しみながら進めることができました。</br>
しかしながら、最後に作業を予定していたテストコードの作成に大変苦戦しました。

時間をかけて方法を検討しましたが、最終的にminitestでメソッドがエラーなく実行できているかを確認するに止まっています。

