class User < ApplicationRecord

  has_many :twitter_threads

  def self.create_or_update_with_omniauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user
      user.update_attribute(:email, auth.info.email)
      user.update_attribute(:name, auth.info.name)
      user.update_attribute(:nickname, auth.info.nickname)
      user.update_attribute(:access_token, auth.extra.access_token.token)
      user.update_attribute(:access_token_secret, auth.extra.access_token.secret)
      user
    else
      create! do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.nickname = auth.info.nickname
        user.access_token = auth.extra.access_token.token
        user.access_token_secret = auth.extra.access_token.secret
      end
    end
  end

end
