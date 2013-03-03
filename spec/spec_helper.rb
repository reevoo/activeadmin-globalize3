require 'bundler'


Bundler.require :default, :test

require 'combustion'
Combustion.initialize! :active_record, :action_controller,
                       :action_view, :sprockets, :action_mailer

require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist
require 'rspec/rails'
require 'capybara/rails'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.order = "random"
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
