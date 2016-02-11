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

  get '/' do
    redirect '/link'
  end

  get '/link' do
    @link = Link.all
    @user = session[:name]
    erb :index
  end

  get '/link/add-new' do
    erb :add_new
  end

  post '/link' do
    link = Link.create(url: params[:url], bookmark_name: params[:bookmark_name])
    params[:tag].split(", ").each do |new_tag|
      new_tags =Tag.create(bookmark_name: params[:bookmark_name], tag: new_tag)
    link.tags << new_tags
    link.save
      end
    redirect to ('/link')
  end

  post '/new-user' do
    @user = User.create(name: params[:name], email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])

    session[:user_id] = @user.id

    if @user.valid?
      redirect to '/link'
    else
      flash.now[:error] = "Error: Password mismatch"
      erb :signup
    end
  end

  get '/link/tag/:tag' do
    tag = Tag.first(tag: params[:tag])
    @link = tag ? tag.links : []
    erb :index
  end

  get '/user/new' do
    @user = User.new
    erb :signup
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
