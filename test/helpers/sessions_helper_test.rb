require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:john)
    session[:user_id] = @user.id
  end

  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
  end

  test "current_user returns nil when locked" do
    @user.update_attribute(:is_locked, true)
    assert_nil current_user
  end

end