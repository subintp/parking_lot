AUTO_LOAD_PATH = ['./lib', './models', './config']

AUTO_LOAD_PATH.each do |dir|

  Dir["#{dir}/**/*.rb"].each do |file|
    require_relative "#{file}"
  end

end
require_relative './parking_service.rb'