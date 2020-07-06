require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @twitter_thread = twitter_threads(:one)
    @tweet = tweets(:one)
    get '/auth/twitter/callback'
  end

  test "should get new" do
    get new_twitter_thread_tweet_url(@twitter_thread)
    assert_response :success
  end

  test "should create tweet" do
    assert_difference('Tweet.count') do
      post twitter_thread_tweets_url(@twitter_thread), params: { tweet: { content: @tweet.content } }
    end

    assert_response :success
  end

  test "should update tweet" do
    patch url_for([@twitter_thread, @tweet]), params: { tweet: { content: @tweet.content } }
    assert_response :success
  end

  test "should destroy tweet" do
    assert_difference('Tweet.count', -1) do
      delete url_for([@twitter_thread, @tweet])
    end

    assert_redirected_to @twitter_thread
  end
end
