require 'minitest/autorun'
require './lib/scraping_for_test'

class ScrapingTest < Minitest::Test

  def setup
    @crawler = Crawler::Zaim.new
  end

  def test_scraping
    # ログインに成功しているか
    assert @crawler.login

    # 入力履歴の検索に成功しているか
    assert @crawler.count
    
    # 履歴の抽出に成功しているか
    assert @crawler.extraction
  end
end
