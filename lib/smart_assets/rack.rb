# frozen_string_literal: true

module SmartAssets
  class Rack

    def initialize(app, prefix, cache_control)
      @app = app
      @prefix = prefix
      @cache_control = cache_control
    end

    def call(env)
      unless is_asset?(env) && (digest_asset=digest_name(env))
        return @app.call(env)
      end

      digest_path = File.join(manifest.dir, digest_asset)
      if File.exist?(digest_path)
        env['PATH_INFO'] = "#{@prefix}/#{digest_asset}"
      end
      status, headers, body = @app.call(env)
      if [200, 206].include?(status)
        # rack 2 expects Mixed-Case headers, while rack 3 expects lower-case. rails doesn't ensure
        # either one. normal controller actions use ActionDispatch::Response::Headers, which maps
        # to rack 2's HeaderHash or rack 3's Headers, both of which are case-insensitive extensions
        # to Hash. however, some responses (ActionDispatch::Static among them), just use Hash.
        # more, Static relies on the user-configurable public_file_server.headers setting, which
        # may have unpredictable casing regardless of the rails or rack version.
        headers = ActionDispatch::Response::Headers[headers] if defined? ActionDispatch::Response::Headers

        # keep Mixed-Case as long as supporting rails <= 7.0 or rack 2
        headers['Cache-Control'] = @cache_control
        headers['ETag'] ||= %("#{digest(digest_asset)}")
      end
      [status, headers, body]
    end


    def is_asset?(env)
      case env['REQUEST_METHOD']
      when 'GET', 'HEAD'
        env['PATH_INFO'].start_with?(@prefix)
      else
        false
      end
    end

    def base_path(env)
      env['PATH_INFO'].sub(%r{^#{@prefix}/}, '')
    end

    def digest_name(env)
      manifest.assets[base_path(env)]
    end

    def digest(name)
      manifest.files[name]['digest']
    end

    def manifest
      ActionView::Base.assets_manifest
    end

  end
end
