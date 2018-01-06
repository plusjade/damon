class CategoryList
  include ActionView::Helpers::DateHelper

  attr_reader :user_id

  def initialize(user_id:)
    @user_id = user_id
  end

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
    entry = Entry.descending.where(user_id: user_id, category_id: category_id).first
    entry ? entry.days_ago : 0
  end

  def days_since_first(category)
    category_id = category_ids_by_name[category]
    entry = Entry.ascending.where(user_id: user_id, category_id: category_id).first
    entry ? entry.days_ago : 0
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
    total_entries_last_7 = category_totals_by_name_last_7[category]
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

    first_entry_in_words = time_ago_in_words(days_since_first(category).days.ago)

    {
      name: category,
      summary: "active #{active}",
      total: total_entries,
      emoji_id: emoji,
      emoji: EMOJIS[emoji],
      daysAgo: days_since_last,
      summaries: [
        "Your last entry was #{active}",
        ("You've created #{total_entries_last_7} entries in the last 7 days" unless total_entries_last_7.zero?),
        "You've created #{total_entries} total entries over the past #{first_entry_in_words}"
      ].compact
    }
  end

  def category_totals_by_name
    @category_totals_by_name ||= begin
      all_categories = category_ids_by_name.reduce({}) { |memo, (name, _)| memo[name] = 0; memo }
      Entry.where(user_id: user_id).group(:category).count.reduce(all_categories) do |memo, (cat, count)|
        memo[cat.name] = count
        memo
      end
    end
  end

  def category_totals_by_name_last_7
    @category_totals_by_name_last_7 ||= begin
      all_categories = category_ids_by_name.reduce({}) { |memo, (name, _)| memo[name] = 0; memo }
      age_ago = Date.today.in_time_zone(PT) - 7.days
      Entry.where(user_id: user_id).where("occurred_at >= ?", age_ago).group(:category).count.reduce(all_categories) do |memo, (cat, count)|
        memo[cat.name] = count
        memo
      end
    end
  end

  def category_ids_by_name
    @category_ids_by_name ||= begin
      Category.where(user_id: user_id).all.select(:id, :name).reduce({}) do |memo, cat|
        memo[cat.name] = cat.id
        memo
      end
    end
  end
end
