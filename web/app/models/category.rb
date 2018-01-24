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

  def emoji
    if name == "instacart"
      "🥕"
    elsif name == "family"
      "👨‍👩‍👧‍👦"
    elsif %w(relationships dating).include?(name)
      "👩"
    elsif %w(project).include?(name)
      "🤓"
    elsif %w(gym exercise).include?(name)
      "🏋️"
    elsif name == "chess"
      "♜"
    elsif name == "reading"
      "📚"
    else
      "🗄️"
    end
  end
end
