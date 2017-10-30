ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

class MakersBnb < Sinatra::Base

get "/" do
  "Test"
  erb :homepage
end

get "/spaces/new" do
  erb :'spaces/new'
end

post "/all_spaces" do
  redirect "/all_spaces"
end

get "/all_spaces" do
  erb :'spaces/all_spaces'
end

run! if app_file == $0

end
