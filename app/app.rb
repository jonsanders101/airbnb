ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base

get "/" do
  erb :homepage
end

post "/users" do
  user = User.create(username: params[:username],
              password: params[:password])
  redirect "/"
end

get "/sign-up" do
  erb :'users/sign_up'
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
