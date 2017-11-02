class Sub < ApplicationRecord

  validates :title, :description, :moderator, presence: true

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :creator_id,
  class_name: :User

  has_many :taggings, dependent: :destroy, inverse_of: :post
  has_many :posts, through: :taggings


end
