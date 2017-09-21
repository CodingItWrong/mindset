source 'https://rubygems.org'

ruby '2.4.2'

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'devise'
gem 'dotenv-rails'
gem 'acts-as-taggable-on', '~> 5.0'

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
  gem 'factory_girl_rails'
  gem 'rspec_junit_formatter' # for circleci
end

group :production do
  gem 'rack-attack'
end
