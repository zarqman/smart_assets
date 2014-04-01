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
      if File.exists?(digest_path)
        env['PATH_INFO'] = "#{@prefix}/#{digest_asset}"
      end
      status, headers, body = @app.call(env)
      if [200, 206].include?(status)
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
