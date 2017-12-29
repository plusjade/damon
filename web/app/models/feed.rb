class Feed
  include ActionView::Helpers::DateHelper

  attr_reader :category_name

  def initialize(category_name:)
    @category_name = category_name
  end

  def feed
    result = entries.map do |entry|
      EntrySerializer.new(entry).as_json.merge({category: category.name})
    end

    max = result.first[:days_ago] + 1
    min = result.last[:days_ago] - 1
    steps = [max, 60, 45, 28, 14, 7]
    total_steps = steps.count
    hits = Array.new(total_steps, false)

    result.map do |e|
      cache = []
      days_ago = e[:days_ago]

      steps.each.with_index do |step, i|
        next if hits[i] # already added the banner
        next if days_ago >= step # older than this step
        younger_than_other_steps = false
        steps.slice(i+1, total_steps).each do |s|
          younger_than_other_steps = days_ago < s
          break if younger_than_other_steps
        end
        next if younger_than_other_steps

        hits[i] = true
        cache << ({
          type: "banner",
          value: "#{step} days",
          color: "#333",
        })

        break
      end

      cache << e
      cache
    end.flatten
  end

  def category
    @category ||= Category.find_by_name!(category_name)
  end

  def entries
    Entry.ascending.where(category: category)
  end
end
