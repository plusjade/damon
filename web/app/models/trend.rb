class Trend
  def self.categories
    Entry.group(:category).count.reduce([]) do |memo, (category, count)|
      memo.push({
        name: category,
        count: count,
      })
      memo
    end.sort_by{ |a| a[:count] }.reverse
  end

  def self.stats
    juicify(generate_trends.shuffle).map.with_index { |t, i| {date: i, close: t}}
  end

  def self.generate_trends
    a = Array.new(60, 0)
    a[9] = 1
    a[10] = 1
    a[14] = 1
    a[20] = 1
    a[21] = 1
    a[31] = 1
    a[33] = 1
    a[35] = 1
    a[50] = 1
    a[52] = 1
    a
  end

  def self.juicify(data)
    health = 0
    data.map do |bool|
      if bool.to_i.zero?
        if health > 0
          health -= 1/7.to_f
          health = 0 if health < 0
        end
      else
        health += 1
      end

      health.round(2)
    end
  end
end
