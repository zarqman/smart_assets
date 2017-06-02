# SmartAssets

SmartAssets is a Rack Middleware for Rails that enables delivery of non-digest assets when using the default asset pipeline.

It solves the problem of production environment requests for assets (eg: `application.css`) returning a 404 because they do not contain a digest (eg: `application-1c8db23293725a8857e5132d59211909.css`).

In general, Rails' default behavior of requiring a digest is a good idea. Serving asset files without a digest can easily result in assets being cached for long periods of time, making them impossible to update. Consider yourself warned.

At the same time, there are legitimate reasons to serve assets without a digest in the name, among them using assets with 404 and other error pages and with 3rd-party applications and sites.

## Usage

This middleware works by reading the sprockets manifest file and internally changing the HTTP request to reflect the digested name. If your manifest is out of date, you will still get 404s.

In order to minimize the risks of long caching while using this gem, requests where the requested filename is mutated will set `Cache-Control: public,max-age=60`.

This can be configured in your environment files (or an initializer). `max-age` is in seconds. If you've configured apache or nginx to set Cache-Control, you may need to ensure that configuration doesn't override this.

    config.smart_assets.cache_control = 'public,max-age=60'

Caching by browsers and proxies can be disabled entirely with:

    config.smart_assets.cache_control = 'max-age=0,no-cache,no-store'

This middleware may also be diabled on a per-environment basis with:

    config.smart_assets.serve_non_digest_assets = false

The default is disabled for `development` and enabled for all other environments.

When this middleware is enabled for a given environment, it automatically enables serving of static files.


## Installation

Add this line to your application's Gemfile:

    gem 'smart_assets'

And then execute:

    $ bundle


## Contributing

1. Fork it ( https://github.com/zarqman/smart_assets/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
