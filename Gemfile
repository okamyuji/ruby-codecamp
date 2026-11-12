# frozen_string_literal: true

# Dependabot の cooldown は Bundler の解決に渡らず、推移的な gem には効かないので、Bundler 自身の待機をかける
source 'https://rubygems.org', cooldown: 3
ruby '~> 4.0'

# solutions/05_math_numbers で使う bundled gem
gem 'prime'

group :development do
  gem 'rubocop', '~> 1.92', require: false
  gem 'rubocop-performance', require: false
end

group :test do
  gem 'minitest', '~> 6.1'
  gem 'rake', '~> 13.4'
end
