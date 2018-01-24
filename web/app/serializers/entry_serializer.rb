class EntrySerializer < ActiveModel::Serializer
  attribute :id

  attribute :type do
    :entry
  end

  attribute :occurred_at do
    object.occurred_at
  end

  attribute :timestamp do
    object.occurred_at.to_i
  end

  attribute :value do
    object.value.presence || "-" # "automatic ##{category.name}"
  end

  attribute :day do
    Ordinal.to_date(object.ordinal)
  end

  attribute :days_ago

  attribute :color do
    month = Ordinal.to_time(object.ordinal).strftime("%m").to_i
    Entry::MONTH_COLORS[month]
  end
end
