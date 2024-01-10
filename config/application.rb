require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IdealConnect
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    # Active Storageのルーティングが、通常の設定ではroutes.rbよりあとに来てしまうので、
    # 例外処理のURLの処理がActive Storageの画像を取り出す前に、行われてしまいイメージが表示されない為、
    # Active Storageを先にロードする為の記述。
    config.railties_order = [ActiveStorage::Engine, :main_app, :all]
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
