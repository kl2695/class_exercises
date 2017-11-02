class Post < ApplicationRecord

  validates :title, :url, :sub, :author, presence: true


  belongs_to :sub

  belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User


  has_many :taggings, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :taggings

  has_many :comments

end
