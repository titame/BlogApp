class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_one :picture, as: :imageable
  validates :title, length: { minimum: 3, maximum: 15}
  validates :description, presence: true
end
