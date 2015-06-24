unless Rails.env.production?
  ENV['FACEBOOK_ID'] = ""
  ENV['FACEBOOK_SECRET'] = ""
  ENV['TWITTER_ID'] = ''
  ENV['TWITTER_SECRET'] = ''
  ENV["GOOGLE_CLIENT_ID"] = ""
  ENV["GOOGLE_CLIENT_SECRET"] = ""
end
