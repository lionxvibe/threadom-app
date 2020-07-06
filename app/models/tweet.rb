class Tweet < ApplicationRecord
  belongs_to :twitter_thread

  validates :content, length: { minimum: 1,  maximum: 250 }

  before_create :set_position

  private

  def set_position
    self.position = self.twitter_thread.tweets.count + 1
  end
end
