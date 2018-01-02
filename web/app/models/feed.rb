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

    max = result.first[:days_ago] + 1
    steps = [max, 60, 45, 28, 14, 7, 1, 0]
    steps = steps.select { |step| step <= max }

    total_steps = steps.count
    hits = Array.new(total_steps, false)

    collector = steps.reduce({}) { |memo, step| memo[step] = [] ; memo}

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

    collector.reduce([]) do |memo, (step, entries)|
      value = "#{step} days"
      value = "Yesterday" if step == 1
      value = "Today" if step == 0
      memo << {
        type: "banner",
        value: value,
        color: "#333",
      }

      memo + entries
    end
  end

  def category
    @category ||= Category.where(user_id: user_id).find_by_name!(category_name)
  end

  def entries
    Entry.ascending.where(user_id: user_id, category: category)
  end
end
