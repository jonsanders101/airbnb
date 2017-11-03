require_relative '../phone'

class MakersBnb < Sinatra::Base

  get '/users/new' do
    erb :'users/sign_up'
  end

  post '/users' do
    user = User.create(username: params[:username],
                       email: params[:email],
                       phone_number: params[:phone_number],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:errors] = user.errors.full_messages
      redirect '/'
    end
  end

  get "/users/:id" do
    erb :'users/account'
  end

  get "/users/phone/new" do
    erb :'users/phone'
  end

  post '/users/phone/verify' do
    @phone_number = Sanitize.clean(params[:phone_number])
    if @phone_number.empty?
      redirect to("/users/phone/verify/?error=1")
    end

    begin
      if @error == false
        current_user.phone_number = @phone_number
        if current_user.phone_verified == true
          @phone_number = url_encode(@phone_number)
          redirect to("/users/phone?phone_number=#{@phone_number}&verified=1")
        end

        Phone.send_verification(current_user)
      end
    erb :'users/phone_verify'
    end
  end

  post '/users/phone/success' do
    @code = params[:code]
    current_user.phone_number = @phone_number
    if current_user.phone_verified == true
      @verified = true
    elsif current_user.nil? || current_user.code != @code
      @phone_number = url_encode(@phone_number)
      redirect to("/users/phone?phone_number=#{@phone_number}&error=1")
    else
      current_user.phone_verified = true
      current_user.save
    end
    erb :'users/phone_success'
  end

end
