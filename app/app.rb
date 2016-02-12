ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require 'sinatra/flash'
require 'bcrypt'

require_relative 'data_mapper_setup'
require_relative 'models/link'
require_relative 'helpers/current_user'

class Bookmark < Sinatra::Base
  helpers Helpers
  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'super secret'
  use Rack::MethodOverride

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @link = Link.all
    @user = session[:name]
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], bookmark_name: params[:bookmark_name])
    params[:tag].split(", ").each do |new_tag|
      new_tags =Tag.create(bookmark_name: params[:bookmark_name], tag: new_tag)
    link.tags << new_tags
    link.save
      end
    redirect to ('/links')
  end

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

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])

      if user
        session[:user_id] = user.id
        redirect '/links'
      else
        flash.now[:errors] = ['The email or password is incorrect']
        erb :'sessions/new'
    end
  end

  get '/links/tags/:tag' do
    tag = Tag.first(tag: params[:tag])
    @link = tag ? tag.links : []
    erb :'links/index'
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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
