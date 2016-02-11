ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'models/link'


class Bookmark < Sinatra::Base

  get '/link' do
    @link = Link.all
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


  get '/link/tag/:tag' do
    tag = Tag.first(tag: params[:tag])
    @link = tag ? tag.links : []
    erb :index
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
