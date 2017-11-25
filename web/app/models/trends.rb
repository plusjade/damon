class Trends
  def days
    Entry.last_days.map do |d|
      d[:entries] = begin
        ActiveModelSerializers::SerializableResource.new(
          d[:entries],
          each_serializer: EntrySerializer
        ).as_json
      end

      d
    end
  end

  def categories
    categories_data.keys
  end

  def categories_data
    @categories_data ||= Entry.group(:category).count
  end

  def trends
    categories_data.keys.select(&:present?).map do |category|
      trends_for_category(category)
    end
    .sort_by do |one|
      one[:data].max_by{ |x| x[:health] }[:health]
    end.reverse
  end

  # boolean health
  # Note: days come in in descending order but we need to score
  # momentum health from ascending order so make sure to reverse.
  def boolean_data_for_category(category)
    days.map do |day|
      if day[:entries].find { |a| a[:category] == category }
        day[:ordinal]
      else
        0
      end
    end.reverse
  end

  def juice_for_category(category)
    data = boolean_data_for_category(category)
    Trend.juicify(data).map.with_index do |value, index|
      {
        ordinal: data[index],
        date: index - 28,
        health: value,
        occurred_at: data[index] == 0 ? nil : Ordinal.to_date(data[index]),
      }
    end
  end

  def trends_for_category(category)
    {
      category: category,
      occurrences: categories_data[category],
      data: juice_for_category(category)
    }
  end
end
