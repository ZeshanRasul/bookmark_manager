require_relative '../data_mapper_setup.rb'

class Tag
  include DataMapper::Resource

  has n, :links, through: Resource

  property :id, Serial
  property :bookmark_name, String
  property :tag, String

end
