require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CustomerManagementApp
  class Application < Rails::Application
    config.load_defaults 5.1

    config.time_zone = 'Tokyo'
    # ロケールファイル（国際化のためのデータファイル）のロードパスを設定
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    # ジェネレーターの設定。
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
