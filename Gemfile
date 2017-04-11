source 'https://rubygems.org'

ruby '2.1.9'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.16'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'therubyracer', platform: :ruby
gem 'bcrypt', '~> 3.1.7'
gem 'nokogiri', '~> 1.6.1'
gem 'rails-i18n', '~> 4.0.1'
gem 'foreigner', '~> 1.6.1'
gem 'kaminari', '~> 0.15.1'

gem 'haml-rails'

group :development do
  gem 'ruby-debug-ide'
  gem 'debase'
end

group :test do
  # vagrant@vagrant-ubuntu-trusty-64:/vagrant$ RAILS_ENV=test rake db:create
  # rake aborted!
  # NoMethodError: undefined method `last_comment' for #<Rake::Application:0x007fac817cad00>
  # /home/vagrant/.gem/ruby/2.1.2/gems/rspec-core-3.0.4/lib/rspec/core/rake_task.rb:101:in `define'
  # gem 'rspec-rails', '~> 3.0.0.bata2'
  gem 'rspec-rails', '~> 3.5.0
'
  gem 'spring-commands-rspec', '~> 1.0.1'   # rspecをspring経由で呼び出すために必要
  gem 'capybara', '~> 2.2.1'          # for feature spec
  gem 'factory_girl_rails', '~> 4.4.1'
  # gem 'database_cleaner', '~> 1.2.0'  # テスト実行後にDBをクリア
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
