source 'https://rubygems.org'

ruby '2.6.1'

gem 'rails', '~> 5.2.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'devise'
gem 'doorkeeper'
gem 'dotenv-rails'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'rack-cors', :require => 'rack/cors'
gem 'active_model_serializers', '~> 0.10.0'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'bullet'
  gem 'faker'
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'coderay'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'factory_bot_rails'
  gem 'rspec_junit_formatter' # for circleci
end

group :production do
  gem 'rack-attack'
end
