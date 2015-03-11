class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  validates :post, presence: true
end
