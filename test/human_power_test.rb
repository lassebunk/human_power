require 'test_helper'

class HumanPowerTest < ActionView::TestCase
  test "basic generation" do
    text = HumanPower::Generator.new(self) do
      allow_tree products_path
      allow product_path("one")
      disallow_tree admin_path
      disallow product_path("two")
    end

    assert_equal "User-agent: *\n"\
                 "Allow: /products/\n"\
                 "Allow: /products/one\n"\
                 "Disallow: /admin/\n"\
                 "Disallow: /products/two",
                 text.to_s
  end

  test "user agent helper" do
    text = HumanPower::Generator.new(self) do
      disallow_tree admin_path
      
      googlebot do
        disallow login_path
      end

      bingbot do
        disallow product_path("two")
      end
    end

    assert_equal "User-agent: *\n"\
                 "Disallow: /admin/\n"\
                 "\n"\
                 "User-agent: Bingbot\n"\
                 "Disallow: /products/two\n"\
                 "\n"\
                 "User-agent: Googlebot\n"\
                 "Disallow: /login",
                 text.to_s
  end
end
