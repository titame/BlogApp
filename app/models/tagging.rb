class Tagging < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  has_many :blogs, through: :tags, :source => :tagable, :source_type => 'Blog'
  has_many :comments, through: :tags, :source => :tagable, :source_type => 'Comment'
  scope :search, ->(key) { where("value like ?", "%#{key}%") }
end
