class TwitterThread < ApplicationRecord
  has_many :tweets, dependent: :destroy
  belongs_to :user

  validate :valid_scheduled_at

  private

  def valid_scheduled_at
    unless scheduled_at.nil?
      if Time.current >= scheduled_at
        errors.add(:scheduled_at, 'cannot be in the past')
      end
    end
  end

end
