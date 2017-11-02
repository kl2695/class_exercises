class Tag < ApplicationRecord
  validates :name, presence: true

  has_many :posts, through: :taggings
  has_many :taggings, dependent: :destroy, inverse_of: :tag
end
