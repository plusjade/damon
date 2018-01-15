class UserSerializer < ActiveModel::Serializer
  attribute :userName do
    object.given_name
  end

  attribute :userAvatarUrl do
    object.avatar_url
  end
end
