class Biography < ApplicationRecord
  belongs_to :biography_type
  has_one_attached :image
  has_one_attached :pdf
end
