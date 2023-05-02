class Source < ApplicationRecord
  belongs_to :source_type
  has_many :events

  has_one_attached :image
  has_one_attached :pdf
end
