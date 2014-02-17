require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# Load configs from config.yaml
AppConfig = YAML.load_file("#{Rails.root}config/config.yml")
# Override config options by correct environment
env_options = AppConfig.delete(Rails.env)
AppConfig.merge!(env_options) unless env_options.nil?

module Ecomm
  class Application < Rails::Application
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :en


    
    config.i18n.locale = :en
    config.i18n.enforce_available_locales = true
    config.autoload_paths += Dir["#{config.root}/lib/"]
    config.assets.initialize_on_precompile = false

    config.generators do |g|
      g.test_framework :rspec
    end
    #config.action_mailer.async = true
  end
end
