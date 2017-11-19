class TrendsController < ActionController::Base
  def index

    days = Entry.last_days.map do |d|
      d[:entries] = begin
        ActiveModelSerializers::SerializableResource.new(
          d[:entries],
          each_serializer: EntrySerializer
        ).as_json
      end

      d
    end

    categories_data = Entry.group(:category).count

    categories = categories_data.keys.select(&:present?)

    trends = categories.map do |category|
      data = days.map do |day|
        day[:entries].find { |a| a[:category] == category } ? 1 : 0
      end

      data = Trend.juicify(data)
      data = data.map.with_index do |value, index|
        {
          date: index - 27,
          health: value,
        }
      end

      {
        category: category,
        occurrences: categories_data[category],
        data: data
      }
    end
    .sort_by do |one|
      one[:data].max_by{ |x| x[:health] }[:health]
    end

    render json: {
      days: days,
      trends: trends.reverse,
      categories: categories_data.reduce([]) do |memo, (category, count)|
        memo.push({
          name: category,
          count: count,
        })
        memo
      end.sort_by{ |a| a[:count] }.reverse
    }
  end
end
