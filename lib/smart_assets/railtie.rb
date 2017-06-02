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

        if app.config.respond_to?(:public_file_server)
          app.config.public_file_server.enabled = true  # >= 5.0
        elsif app.config.respond_to?(:serve_static_files)
          app.config.serve_static_files = true          #  = 4.2
        else
          app.config.serve_static_assets = true         # <= 4.1
        end

        app.middleware.insert_after(::Rack::Sendfile, SmartAssets::Rack, prefix, cc)
      end
    end

  end
end
