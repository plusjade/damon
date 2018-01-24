class Feed
  include ActionView::Helpers::DateHelper

  attr_reader :user_id, :category_name

  def initialize(user_id:, category_name:)
    @user_id = user_id
    @category_name = category_name
  end

  def feed
    result = entries.map do |entry|
      EntrySerializer.new(entry).as_json.merge({category: category.name})
    end

    max = result.first ? result.first[:days_ago] + 1 : 0
    steps = [max, 60, 45, 28, 14, 7, 1, 0]
    steps = steps.select { |step| step <= max }

    total_steps = steps.count
    hits = Array.new(total_steps, false)

    collector = steps.reduce({}) { |memo, step| memo[step] = [] ; memo}

    recent_dates = Entry.recent_dates_by_ordinal(reverse: false).dup

    result.each do |e|
      cache = []
      days_ago = e[:days_ago]

      steps.each.with_index do |step, i|
        next if days_ago > step # older than this step
        younger_than_other_steps = false
        steps.slice(i+1, total_steps).each do |s|
          younger_than_other_steps = days_ago <= s
          break if younger_than_other_steps
        end
        next if younger_than_other_steps

        collector[step] << e
      end
    end


    result = collector.reduce([]) do |memo, (step, entries)|
      value = "#{step} days"
      value = "Yesterday" if step == 1
      value = "Today" if step == 0
      # memo << {
      #   id: Digest::MD5.hexdigest(value),
      #   type: "banner",
      #   value: value,
      #   color: "#333",
      # }

      memo + entries
    end

    result.each do |entry|
      recent_dates[Ordinal.from_time(entry[:occurred_at])] << entry
    end

    today = Time.now.in_time_zone(PT).to_date
    recent_dates.reduce([]) do |memo, (ordinal, entries)|
      days_ago = (today - Ordinal.to_time(ordinal).in_time_zone(PT).to_date).to_i
      value = ""
      if steps.include?(days_ago)
        value = "#{days_ago} days - "
        value = "Yesterday - " if days_ago == 1
        value = "Today - " if days_ago == 0
      end

      memo << {
        id: rand,
        type: "banner",
        value: "#{value} #{Ordinal.to_date(ordinal, "%a %b %d")}",
        color: "#333",
      }
      memo += entries

      if entries.count.zero?
        memo << {
          id: rand,
          type: "entryPlaceholder",
          value: "😴",
          day: "#{Ordinal.to_date ordinal}",
          color: "#333",
        }
      end

      memo
    end
  end

  def category
    @category ||= Category.where(user_id: user_id).find_by_name!(category_name)
  end

  def entries
    Entry.ascending.where(user_id: user_id, category: category)
  end
end
