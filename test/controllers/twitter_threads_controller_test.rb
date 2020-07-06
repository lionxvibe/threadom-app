require 'test_helper'

class TwitterThreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @twitter_thread = twitter_threads(:one)
    @posted_twitter_thread = twitter_threads(:posted)
    get '/auth/twitter/callback'
  end


  test "should get index" do
    get twitter_threads_url
    assert_response :success
  end

  test "should get new" do
    get new_twitter_thread_url
    assert_response :success
  end

  test "should create twitter_thread" do
    assert_difference('TwitterThread.count') do
      post twitter_threads_url, params: { twitter_thread: { scheduled_at: @twitter_thread.scheduled_at } }
    end

    assert_redirected_to twitter_thread_url(TwitterThread.last)
  end

  test "should show twitter_thread" do
    get twitter_thread_url(@twitter_thread)
    assert_response :success
  end

  test "should get edit" do
    get edit_twitter_thread_url(@twitter_thread)
    assert_response :success
  end

  test "should update twitter_thread" do
    patch twitter_thread_url(@twitter_thread), params: { twitter_thread: { scheduled_at: @twitter_thread.scheduled_at } }
    assert_redirected_to @twitter_thread
  end

  test "should not update posted_twitter_thread" do
    patch twitter_thread_url(@posted_twitter_thread), params: { twitter_thread: { scheduled_at: @posted_twitter_thread.scheduled_at } }
    assert_redirected_to twitter_threads_path
  end

  test "should destroy twitter_thread" do
    assert_difference('TwitterThread.count', -1) do
      delete twitter_thread_url(@twitter_thread)
    end

    assert_redirected_to twitter_threads_url
  end
end
