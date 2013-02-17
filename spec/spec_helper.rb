require 'rspec/autorun'
Bundler.require(:default, :development)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
end
