%w(rack railtie version).each do |f|
  require "smart_assets/#{f}"
end
