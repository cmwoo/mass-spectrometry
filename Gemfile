source 'https://rubygems.org'

gem 'rails', '3.2.16'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

group :development,:test do  
  # ... other gems
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  gem 'rspec-rails', '~> 2.14.0'
  gem 'simplecov'
  gem 'rake'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

gem 'jquery-rails'
gem 'haml'
gem 'devise'
gem 'aws-sdk', '~> 1'
gem 'aws-sdk-resources', '~> 2'

# To use foreign keys, need new gem
gem 'foreigner', '~> 1.7.4'

gem 'net-ssh'

gem 'delayed_job_active_record'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
