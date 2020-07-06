class TweetThreadJob < ApplicationJob

  attr_accessor :twitter_client

  queue_as :default

  def perform(twitter_thread)
    return if twitter_thread.posted_at.present? || Time.current < twitter_thread.scheduled_at

    client = twitter_client twitter_thread.user

    published_ids = []

    begin
      # Tweet the first tweet
      first_tweet = client.update(twitter_thread.tweets.first.content)
      published_ids << first_tweet.id

      twitter_thread.tweets[1..-1].each do |tweet|
        reply = client.update(tweet.content, in_reply_to_status_id: published_ids.last)
        published_ids << reply.id
      end
      twitter_thread.update_attribute(:posted_at, Time.current.utc)
    rescue
      client.destroy_status published_ids
    end
  end

  def twitter_client(user)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        =  ENV['TWITTER_ID'] || Rails.application.credentials.twitter[:id]
      config.consumer_secret     =  ENV['TWITTER_SECRET'] || Rails.application.credentials.twitter[:secret]
      config.access_token        = user.access_token
      config.access_token_secret = user.access_token_secret
    end
  end
end