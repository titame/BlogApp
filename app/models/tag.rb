class Tag < ActiveRecord::Base
  belongs_to :tagable, polymorphic: true
  validates :values, format: {with: /([a-z]+)(,[a-z]+)*/, message: "tags should be comma separated"}
end
