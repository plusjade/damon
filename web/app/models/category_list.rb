class CategoryList
  include ActionView::Helpers::DateHelper

  def payload
    category_totals_by_name.keys.sort.map do |category|
      data_for_category(category)
    end
  end

  def days_since_last(category)
    category_id = category_ids_by_name[category]
    entry = Entry.descending.where(category_id: category_id).first
    entry ? entry.days_ago : nil
  end

  def data_for_category(category)
    total_entries = category_totals_by_name[category]
    days_since_last = days_since_last(category)
    emoji = nil

    if days_since_last <= 3
      if total_entries >= 10
        emoji = "🔥🔥🚀"
      elsif total_entries >= 5
        emoji = "🔥🔥"
      else
        emoji = "🌱🌱"
      end
    elsif days_since_last <= 7
      if total_entries >= 10
        emoji = "🔥🔥"
      elsif total_entries >= 5
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
      summary: "active #{active} — #{total_entries} total",
      emoji: emoji,
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
