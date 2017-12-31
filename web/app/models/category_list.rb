class CategoryList
  include ActionView::Helpers::DateHelper

  def payload
    category_totals_by_name.keys.map do |category|
      data_for_category(category)
    end.sort do |a, b|
      if a[:emoji_id] == b[:emoji_id]
        a[:name] <=> b[:name]
      else
        a[:emoji_id] <=> b[:emoji_id]
      end
    end
  end

  def days_since_last(category)
    category_id = category_ids_by_name[category]
    entry = Entry.descending.where(category_id: category_id).first
    entry ? entry.days_ago : nil
  end

  EMOJIS = {
    1 => "🔥🔥🚀",
    2 => "🔥🔥",
    3 => "🔥",
    4 => "🌱🌱",
    5 => "🌱",
    6 => "🤒",
    7 => "😴",
  }

  def data_for_category(category)
    total_entries = category_totals_by_name[category]
    days_since_last = days_since_last(category)
    emoji = nil

    if days_since_last <= 3
      if total_entries >= 10
        emoji = 1
      elsif total_entries >= 5
        emoji = 2
      else
        emoji = 4
      end
    elsif days_since_last <= 7
      if total_entries >= 10
        emoji = 2
      elsif total_entries >= 5
        emoji = 3
      else
        emoji = 5
      end
    elsif days_since_last <= 14
      emoji = 6
    else
      emoji = 7
    end

    active = if days_since_last.zero?
                "today"
              else
                "#{time_ago_in_words(days_since_last.days.ago)} ago"
              end
    {
      name: category,
      summary: "active #{active} — #{total_entries} total",
      emoji_id: emoji,
      emoji: EMOJIS[emoji],
      daysAgo: days_since_last,
    }
  end

  def category_totals_by_name
    @category_totals_by_name ||= begin
      Entry.group(:category).count.reduce({}) do |memo, (cat, count)|
        memo[cat.name] = count
        memo
      end
    end
  end

  def category_ids_by_name
    @category_ids_by_name ||= begin
      Category.all.select(:id, :name).reduce({}) do |memo, cat|
        memo[cat.name] = cat.id
        memo
      end
    end
  end
end
