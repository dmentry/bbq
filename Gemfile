source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'puma', '~> 4.1'
gem 'webpacker', '~> 4.0'
gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'

# гем для перевода сообщений девайса
gem 'devise-i18n'
gem 'rails-i18n'

# гем для загрузки картинок
gem 'carrierwave'

# гем для обработки картинок
gem 'rmagick'

# гем для работы carrierwave с хранилищем Amazon S3
gem 'fog-aws'
gem 'mailjet'
gem 'bootsnap', '>= 1.4.2', require: false

# авторизация
gem 'pundit'

# бэкенд-адаптер
gem 'resque'


# гем для работы с OAuth—протоколом для авторизации клиента через сторонний сервис
gem 'omniauth'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-vkontakte'
gem 'omniauth-rails_csrf_protection'

group :production do
  # в продакшен сервере heroku этот гем соединяет с базой данных Postgres
  gem 'pg'
end

group :development, :test do
  gem 'pry'
  gem 'sqlite3', '~> 1.4'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'letter_opener'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'

  gem 'capistrano', '~> 3.10'
  gem 'capistrano-rails', '~> 1.6'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-bundler', '~> 2.0'
  gem "capistrano-resque", "~> 0.2.3", require: false
end
