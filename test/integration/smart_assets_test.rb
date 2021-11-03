require "test_helper"

class SmartAssetsTest < ActionDispatch::IntegrationTest

  test "routes are served normally" do
    get '/'
    assert_response 200
    assert_equal 320, response.body.size
    assert_equal 'max-age=0, private, must-revalidate', response.headers['cache-control']
    assert_match %r{W/"[0-9a-f]{32}"}, response.headers['etag']
  end

  test "public/ is served normally" do
    get '/static.txt'
    assert_response 200
    assert_equal 12, response.body.size
    assert_equal 'public, max-age=3600', response.headers['cache-control'], 'should come from rails'
    refute response.headers['etag']
  end

  test "assets with digest are served normally" do
    get %Q{/assets/application-#{app_css_info[:digest]}.css}
    assert_response 200
    assert_equal app_css_info[:size], response.body.size
    assert_equal 'public, max-age=3600', response.headers['cache-control'], 'should come from rails'
    refute response.headers['etag']
  end

  test "assets without digest are served by smart_assets" do
    get '/assets/application.css'
    assert_response 200
    assert_equal app_css_info[:size], response.body.size
    assert_equal 'public,max-age=60', response.headers['cache-control'], 'should come from smart_assets'
    assert_equal %Q{"#{app_css_info[:sha256]}"}, response.headers['etag']
  end
  
  test "POST properly errors" do
    post '/assets/application.css'
    assert_response 404
  end


  def app_css_info
    @app_css_info ||= begin
      fn = Dir['test/dummy/public/assets/application-*.css'].first
      c = File.read(fn)
      { size:     c.bytesize,
        contents: c,
        digest:   fn.match(/application-(.+)\.css$/)[1],
        sha256:   Digest::SHA256.hexdigest(c)
      }
    end
  end

end
