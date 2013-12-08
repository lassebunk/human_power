require 'test_helper'

class GeneratorTest < ActionView::TestCase
  test "basic generation" do
    generator = HumanPower::Generator.new(self) do
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
                 generator.render
  end

  test "user agent helper" do
    generator = HumanPower::Generator.new(self) do
      disallow_tree admin_path
      
      googlebot do
        allow product_path("one")
        disallow_tree products_path
        disallow login_path
      end

      bingbot do
        allow login_path
        allow_tree products_path
        disallow product_path("two")
      end
    end

    assert_equal "User-agent: *\n"\
                 "Disallow: /admin/\n"\
                 "\n"\
                 "User-agent: Bingbot\n"\
                 "Allow: /login\n"\
                 "Allow: /products/\n"\
                 "Disallow: /products/two\n"\
                 "\n"\
                 "User-agent: Googlebot\n"\
                 "Allow: /products/one\n"\
                 "Disallow: /products/\n"\
                 "Disallow: /login",
                 generator.render
  end

  test "custom user agent" do
    generator = HumanPower::Generator.new(self) do
      disallow_tree admin_path

      user_agent "My Custom User Agent" do
        disallow login_path
        allow_tree products_path
      end
    end

    assert_equal "User-agent: *\n"\
                 "Disallow: /admin/\n"\
                 "\n"\
                 "User-agent: My Custom User Agent\n"\
                 "Disallow: /login\n"\
                 "Allow: /products/",
                 generator.render
  end

  test "user agent as symbol" do
    generator = HumanPower::Generator.new(self) do
      disallow_tree admin_path

      user_agent :googlebot do
        disallow login_path
        allow_tree products_path
      end
    end

    assert_equal "User-agent: *\n"\
                 "Disallow: /admin/\n"\
                 "\n"\
                 "User-agent: Googlebot\n"\
                 "Disallow: /login\n"\
                 "Allow: /products/",
                 generator.render
  end

  test "multiple user agents" do
    generator = HumanPower::Generator.new(self) do
      disallow_tree admin_path

      user_agent ["My Custom User Agent", :googlebot] do
        disallow login_path
        allow_tree products_path
      end
    end

    assert_equal "User-agent: *\n"\
                 "Disallow: /admin/\n"\
                 "\n"\
                 "User-agent: Googlebot\n"\
                 "Disallow: /login\n"\
                 "Allow: /products/\n"\
                 "\n"\
                 "User-agent: My Custom User Agent\n"\
                 "Disallow: /login\n"\
                 "Allow: /products/",
                 generator.render
  end

  test "sitemaps" do
    generator = HumanPower::Generator.new(self) do
      disallow_tree admin_path

      sitemap "http://test.com/sitemap.xml"
      sitemap "http://test.com/one.xml", "http://test.com/two.xml"
      sitemap "http://test.com/two.xml"
    end

    assert_equal "Sitemap: http://test.com/sitemap.xml\n"\
                 "Sitemap: http://test.com/one.xml\n"\
                 "Sitemap: http://test.com/two.xml\n"\
                 "\n"\
                 "User-agent: *\n"\
                 "Disallow: /admin/",
                 generator.render
  end
end
