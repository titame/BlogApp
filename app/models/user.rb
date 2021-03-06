class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :blogs
  has_many :comments
  has_one :picture, as: :imageable
  accepts_nested_attributes_for :picture
end
