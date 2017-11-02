class Track < ApplicationRecord

  validates :title, :ord, :album_id, presence: true

  belongs_to :album,
  primary_key: :id,
  foreign_key: :album_id,
  class_name: :Album

  

end
