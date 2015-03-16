class Tag < ActiveRecord::Base
  belongs_to :tagable, polymorphic: true
  belongs_to :tagging
  scope :find_tagged_ids, ->(tagable_type, tagging_id) { select('tagable_id').where("tagable_type = ? AND tagging_id = ?", tagable_type, tagging_id) }
end
