class BookmarkManager < Sinatra::Base
  post '/users' do
    @user = User.create(name: params[:name], email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])


    if @user.valid?
      session[:user_id] = @user.id

      redirect to '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  delete'/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'Goodbye!'
    redirect '/links'
  end

end
