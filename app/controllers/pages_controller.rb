class PagesController < ApplicationController

  before_action :set_twitter_client

  def home
    if current_user.present?
      @twitter_threads = TwitterThread.where(user: current_user)
      render 'twitter_threads/index'
    end
  end

  private

  def set_twitter_client
    return if current_user.nil?

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        =  ENV['TWITTER_ID'] || Rails.application.credentials.twitter[:id]
      config.consumer_secret     =  ENV['TWITTER_SECRET'] || Rails.application.credentials.twitter[:secret]
      config.access_token        = current_user.access_token
      config.access_token_secret = current_user.access_token_secret
    end
  end
end
