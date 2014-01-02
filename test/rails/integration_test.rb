require "test_helper"

class IntegrationTest < ActionDispatch::IntegrationTest
  test "robots.txt" do
    get "/robots.txt"
    assert_response :success

    assert_equal "Sitemap: http://www.example.com/sitemap.xml\n"\
                 "\n"\
                 "User-agent: *\n"\
                 "Disallow: /admin/\n"\
                 "\n"\
                 "User-agent: Bingbot\n"\
                 "Disallow: /\n"\
                 "\n"\
                 "User-agent: Googlebot\n"\
                 "Disallow: /products/one",
                 body
  end
end