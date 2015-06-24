require 'omniauth-google-oauth2'

Devise.setup do |config|
	config.omniauth :facebook, ENV["FACEBOOK_ID"], ENV["FACEBOOK_SECRET"]
	config.omniauth :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET']
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {access_type: 'offline', approval_prompt: 'force'}
end
