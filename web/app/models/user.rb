require 'securerandom'

class User < ApplicationRecord
  has_many :categories
  has_many :entries

  before_create :set_access_token
  after_create_commit :add_default_category

  def set_access_token
    unless access_token
      self.access_token = SecureRandom.uuid
    end
  end

  def add_default_category
    unless categories.exists?
      categories.create(name: signup_category || "exercise")
    end
  end

  def self.find_or_create_from_google(response, attributes={})
    User.where(google_sub: response["sub"]).first_or_create!({
      email: response["email"],
      given_name: response["given_name"],
      avatar_url: response["picture"],
    }.merge(attributes))
  end
end
