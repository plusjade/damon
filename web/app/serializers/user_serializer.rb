class UserSerializer < ActiveModel::Serializer
  attributes :email

  attribute :userName do
    object.given_name
  end

  attribute :userAvatarUrl do
    object.avatar_url
  end
end
