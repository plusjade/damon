class User < ApplicationRecord
  has_many :categories
  has_many :entries

  def self.find_or_create_from_google(response)
    User.where(google_sub: response["sub"]).first_or_create!({
      email: response["email"]
    })
  end
end
