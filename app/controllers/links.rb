class BookmarkManager < Sinatra::Base

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

end
