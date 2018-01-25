class EntrySerializer < ActiveModel::Serializer
  attribute :id

  attribute :type do
    :entry
  end

  attribute :occurred_at do
    object.occurred_at
  end

  attribute :value do
    object.value.presence || ""
  end

  attribute :minorValue do
    object.category.emoji
  end

  attribute :days_ago

  attribute :color do
    month = Ordinal.to_time(object.ordinal).strftime("%m").to_i
    Entry::MONTH_COLORS[month]
  end
end
