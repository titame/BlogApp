class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_one :tag, as: :tagable, dependent: :destroy
  accepts_nested_attributes_for :tag
  validates :post, presence: true
  validates_associated :tag
end
