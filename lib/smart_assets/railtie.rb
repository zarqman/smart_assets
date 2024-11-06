module SmartAssets
  class Railtie < Rails::Railtie

    config.smart_assets = ActiveSupport::OrderedOptions.new
    config.smart_assets.cache_control = 'public,max-age=60'
    config.smart_assets.prefix = nil
    config.smart_assets.serve_non_digest_assets = !Rails.env.development?

    initializer 'smart_assets.configure' do |app|
      if app.config.smart_assets.serve_non_digest_assets
        prefix = app.config.smart_assets.prefix || app.config.assets.prefix || '/assets'
        cc = app.config.smart_assets.cache_control

        app.config.public_file_server.enabled = true

        app.middleware.insert_after(::Rack::Sendfile, SmartAssets::Rack, prefix, cc)
      end
    end

  end
end
