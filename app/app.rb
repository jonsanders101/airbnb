ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base

  get "/" do
    # TODO: remove next line
    "Test"
    erb :homepage
  end

  get "/spaces/new" do
    erb :'spaces/new'
  end

  post "/spaces" do
    space = Space.create(name: params[:space],
                        host_id: session[:user_id],
                        description: params[:description],
                        price: params[:price])
    redirect "/spaces"
  end

  get "/spaces" do
    erb :'spaces/index'
  end

  helpers do
    def spaces
      @spaces ||= Space.all
    end
  end

  run! if app_file == $0

end
