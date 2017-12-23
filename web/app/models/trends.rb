class Trends
  def days_with_months
    month = nil

    days.map do |d|
      entries = d[:entries]
      if d[:month] != month
        month = d[:month]
        [
          {
            type: "banner",
            value: Date::MONTHNAMES[month],
            color: Entry::MONTH_COLORS[month],
          },
          d
        ]
      else
        [d]
      end + entries

    end.flatten
  end

  def days
    @days ||= begin
      Entry.last_days.map do |d|
        d[:entries] = d[:entries].map do |entry|
          {
            id: entry.id,
            value: entry.value,
            category: categories_by_id[entry.category_id].name,
            type: :entry,
          }
        end

        d
      end
    end
  end

  def categories_by_id
    @categories_by_id ||= Category.all.index_by(&:id)
  end

  def categories
    categories_data.keys
  end

  def categories_data
    @categories_data ||= Entry.group(:category).count.reduce({}) do |memo, (cat, count)|
      memo[cat.name] = count
      memo
    end
  end

  def trends
    categories_data.keys.map do |category|
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
        date: index - Entry::RECENT_DAYS,
        health: value,
        occurred_at: data[index] == 0 ? nil : Ordinal.to_date(data[index]),
      }
    end
  end

  def maxHealth(category)
    juice_for_category(category).max_by{ |x| x[:health] }[:health]
  end

  def days_since_last(category)
    mark = Entry::RECENT_DAYS
    juice_for_category(category).reverse.each.with_index do |day, index|
      if day[:occurred_at]
        mark = index
        break
      end
    end

    mark
  end


  def trends_for_category(category)
    {
      category: category,
      occurrences: categories_data[category],
      maxHealth: maxHealth(category),
      days_since_last: days_since_last(category),
      data: juice_for_category(category),
    }
  end
end
