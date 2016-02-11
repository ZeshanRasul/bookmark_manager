class Link
  include DataMapper::Resource

  has n, :tags, through: Resource

  property :id,   Serial
  property :bookmark_name, String
  property :url, String

end
