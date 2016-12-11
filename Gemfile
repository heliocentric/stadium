source 'https://rubygems.org'
# General gems
gem 'rubocop', '~> 0.41.2', require: false
gem 'rake', '~> 11.3'
gem 'rspec', '~> 3.0'
gem 'simplecov', :require => false, :group => :test
# Stadium gems
gem 'diplomat', '~> 0.17.0'
if (/jruby/ =~ RUBY_PLATFORM)
	gem 'march_hare', '~> 2.16'
else
	gem 'pry'
	gem 'pry-byebug'
	gem 'bunny', '~> 2.3', '>= 2.3.1'
end
