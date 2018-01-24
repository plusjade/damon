class Category < ApplicationRecord
  has_many :entries
  has_many :prompts
  belongs_to :user, dependent: :destroy

  before_save :normalize

  def normalize
    if name
      self.name = name.to_s.downcase
    end
  end
end
