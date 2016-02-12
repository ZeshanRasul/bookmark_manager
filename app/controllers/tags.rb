class BookmarkManager < Sinatra::Base

  get '/links/tags/:tag' do
    tag = Tag.first(tag: params[:tag])
    @link = tag ? tag.links : []
    erb :'links/index'
  end
end
