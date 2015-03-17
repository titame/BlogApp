class Blog < ActiveRecord::Base
  include TaggingSearch

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :picture, as: :imageable, dependent: :destroy
  has_many :tags, as: :tagable, dependent: :destroy
  has_many :taggings, through: :tags
  accepts_nested_attributes_for :picture
  attr_accessor :values

  validates :title, length: { minimum: 3, maximum: 15}
  validates :description, presence: true

  scope :publishable_blogs, -> { where(status: ["post-published","post-republished"])}
  scope :paginate_blogs, ->(val) { limit(5).offset(val).order(created_at: :desc) }
  after_create :create_tagging

  def create_tagging
    tag_vals = values.split(',')
    tag_vals.each do |tag_val|
      if (tagging = Tagging.find_by(value: tag_val))
        tag = tags.create
        tag.tagging = tagging
        tag.save
      else
        taggings.create(value: tag_val)
      end
    end
  end

  def self.search(key)
    blog_ids = Comment.search_blog_ids(key)
    blogs = where("title like ? OR description like ? OR id IN(?)", "%#{key}%","%#{key}%", blog_ids)
    taggings = Tagging.search(key)
    blogs << taggings.collect do |tagging|
        search_tagged_blogs(tagging.id)
    end
    blogs.flatten.uniq
  end

end
