class EntrySerializer < ActiveModel::Serializer
  attributes :value, :id
  attribute :category do
    object.category.name
  end
end
