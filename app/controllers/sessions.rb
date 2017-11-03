class MakersBnb < Sinatra::Base

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:errors] = ['Woops! Email or password is incorrect.']
      redirect '/'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect '/'
  end

end
