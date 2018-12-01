require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  # full_titleヘルパーに対してのテスト
  test "full_title_helper" do
    assert_equal full_title, "Ruby on Rails Tutorial Sample App"
    assert_equal full_title('About'), "About | Ruby on Rails Tutorial Sample App"
  end
end
