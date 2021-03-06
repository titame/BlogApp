class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :tags, as: :tagable, dependent: :destroy
  has_many :taggings, through: :tags
  accepts_nested_attributes_for :taggings
  attr_accessor :values
  validates :post, presence: true
  scope :search_blog_ids, ->(key) { where("post like ?", "%#{key}%").pluck(:blog_id).uniq }
  after_create :create_tagging

  def create_tagging
    tag_vals = values.split(',')
    tag_vals.each do |tag_val|
      if (tagging_val = Tagging.find_by(value: tag_val))
        tag = tags.create
        tag.tagging = tagging_val
        tag.save
      else
        taggings.create(value: tag_val)
      end
    end
  end

end
