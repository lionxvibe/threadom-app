OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  ENV['TWITTER_ID'] || Rails.application.credentials.twitter[:id], ENV['TWITTER_SECRET'] || Rails.application.credentials.twitter[:secret]

end