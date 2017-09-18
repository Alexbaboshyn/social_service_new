source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end



gem 'rails'
gem 'pg'
gem 'puma'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'bcrypt'
gem 'draper'
gem 'email_validator'
gem "paperclip"
gem 'rails-observers'
gem 'activerecord-postgres-earthdistance'

group :development, :test do
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'byebug', platform: :mri
  gem 'simplecov', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'pry-rails'
end
