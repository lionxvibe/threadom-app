require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "Threadom", full_title
    assert_equal "Threadom - Help", full_title("Help")
  end
end