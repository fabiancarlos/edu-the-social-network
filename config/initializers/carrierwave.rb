CarrierWave.configure do |config|
  # For testing, upload to '/tmp'
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end

  # on heroku
  if Rails.env.production?
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET'],
      :region  => 'sa-east-1'
    }
    config.storage = :fog
  end

  # locally
  if Rails.env.development?
    config.storage = :file
  end
 
  config.cache_dir = "#{Rails.root}/tmp/uploads"   # To let CarrierWave work on heroku
 
  config.fog_directory    = ENV['S3_BUCKET_NAME']
  config.fog_public = true  
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end