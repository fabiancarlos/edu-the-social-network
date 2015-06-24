Rails.application.config.middleware.insert 0, 'Rack::Cors' do
	allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :options]
  end
end