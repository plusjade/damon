class Prompt < ApplicationRecord
  belongs_to :category

  scope :sorted, -> { order("position asc") }
end
