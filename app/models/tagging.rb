class Tagging < ActiveRecord::Base
  has_many :tags, as: :tagable
  has_many :blogs, through: :tags, :source => :tagable, :source_type => 'Blog'
  has_many :comments, through: :tags, :source => :tagable, :source_type => 'Comment'
end
