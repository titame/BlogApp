class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  validates :img_url, presence: true
end
