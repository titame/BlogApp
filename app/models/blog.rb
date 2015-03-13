class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :picture, as: :imageable
  has_one :tag, as: :tagable, dependent: :destroy
  accepts_nested_attributes_for :tag
  accepts_nested_attributes_for :picture
  validates :title, length: { minimum: 3, maximum: 15}
  validates :description, presence: true
  validates_associated :tag, :picture
  scope :publishable_blogs, -> { where(status: ["post-published","post-republished"])}
  scope :paginate_blogs, ->(val) { limit(5).offset(val).order(created_at: :desc) }

end
