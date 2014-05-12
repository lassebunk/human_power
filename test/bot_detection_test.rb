require 'test_helper'

class GeneratorTest < ActionView::TestCase
  test "bot regex matches" do
    bot_user_agents.each do |ua|
      assert_match HumanPower.bot_regex, ua
    end
  end

  test "bot regex browser matches" do
    browser_user_agents.each do |ua|
      assert_no_match HumanPower.bot_regex, ua
    end
  end

  test "bot detection" do
    bot_user_agents.each do |ua|
      assert HumanPower.is_bot?(ua)
    end
  end

  test "browser detection" do
    browser_user_agents.each do |ua|
      assert !HumanPower.is_bot?(ua)
    end
  end

  private

    def bot_user_agents
      ["Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
       "Googlebot/2.1 (+http://www.googlebot.com/bot.html)",
       "Mozilla/4.0 (compatible; B-l-i-t-z-B-O-T)",
       "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)"]
    end

    def browser_user_agents
      ["Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36",
       "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25",
       "Mozilla/5.0 (compatible; MSIE 10.6; Windows NT 6.1; Trident/5.0; InfoPath.2; SLCC1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 2.0.50727) 3gpp-gba UNTRUSTED/1.0"]
    end
end