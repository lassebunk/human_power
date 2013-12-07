require 'test_helper'

class HumanPowerTest < ActionView::TestCase
  test "basic generation" do
    text = HumanPower::File.new(self) do
      disallow_tree admin_path
      disallow product_path("one")
    end

    assert_equal "User-agent: *\n"\
                 "Disallow: /admin/\n"\
                 "Disallow: /products/one",
                 text.to_s
  end
end
