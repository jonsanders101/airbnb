ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

class MakersBnb < Sinatra::Base

get "/" do
  "Test"
end

run! if app_file == $0

end
