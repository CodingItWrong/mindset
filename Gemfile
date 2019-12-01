source 'https://rubygems.org'

ruby '2.6.5'

gem 'rails', '~> 6.0.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 6.0'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'devise'
gem 'doorkeeper'
gem 'dotenv-rails'
gem 'acts-as-taggable-on', '~> 6.5'
gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'bullet'
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'coderay'
  gem 'rubocop'
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
