class Trends
  include ActionView::Helpers::DateHelper
  def days_with_months
    month = nil

    days.reverse.map do |d|
      entries = d[:entries]

      if d[:month] != month

        month = d[:month]
        [
          {
            type: "banner",
            value: "7 days ago",
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
          category = categories_by_id[entry.category_id].name
          {
            id: entry.id,
            timestamp: entry.occurred_at.to_i,
            value: entry.value.presence || "automatic ##{category}",
            category: category,
            day: Ordinal.to_date(entry.ordinal),
            age: (Time.now.to_date - entry.occurred_at.to_date).to_i,
            color: Entry::MONTH_COLORS[d[:month]],
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
    entries = categories_data[category]
    days_since_last = days_since_last(category)
    emoji = nil

    if days_since_last <= 3
      if entries >= 10
        emoji = "🔥🔥🚀"
      elsif entries >= 5
        emoji = "🔥🔥"
      else
        emoji = "🌱🌱"
      end
    elsif days_since_last <= 7
      if entries >= 10
        emoji = "🔥🔥"
      elsif entries >= 5
        emoji = "🔥"
      else
        emoji = "🌱"
      end
    elsif days_since_last <= 14
      emoji = "🤒"
    else
      emoji = "😴"
    end

    active = if days_since_last.zero?
                "today"
              else
                "#{time_ago_in_words(days_since_last.days.ago)} ago"
              end
    {
      name: category,
      summary: "active #{active} — #{entries} total",
      emoji: emoji,
      entries: entries,
      maxHealth: maxHealth(category),
      days_since_last: days_since_last,
      data: juice_for_category(category),
    }
  end
end
