class Entry < ApplicationRecord

  before_save :default_occurred
  before_save :add_ordinals
  before_save :extract_hashtags

  scope :ascending, -> { order("occurred_at asc") }

  HASHTAG_REGEX = /#(\w+)/

  def extract_hashtags
    if (match = self.value.to_s.match(HASHTAG_REGEX))
      self.category = match[1]
    end
  end

  def default_occurred
    if occurred_at.blank?
      if ordinal
        self.occurred_at = Ordinal.to_time(self.ordinal)
      else
        self.occurred_at = Time.now.in_time_zone(Ordinal::PT)
      end
    end
  end

  def add_ordinals
    if ordinal.blank?
      self.ordinal = Ordinal.from_time(occurred_at.in_time_zone(PT))
    end
  end

  def self.last_days
    index = 0
    today_ordinal = Ordinal.from_time(Time.now)
    yesterday_ordinal = Ordinal.from_time(1.day.ago)
    entries_by_ordinal(recent_dates_by_ordinal).reduce([]) do |memo, (ordinal, entries)|
      occurred_at = Ordinal.to_date(ordinal)
      if today_ordinal == ordinal
        occurred_at = "Today"
      elsif yesterday_ordinal == ordinal
        occurred_at = "Yesterday"
      end

      data = {
        occurred_at: occurred_at,
        entries: entries,
        ordinal: ordinal,
        index: index,
      }
      if today_ordinal == ordinal
        data[:isToday] = true
      end

      memo.push(data)
      index += 1
      memo
    end
  end

  RECENT_DAYS = 28

  def self.recent_dates_by_ordinal
    (RECENT_DAYS.days.ago.to_date..Date.today).reduce({}) do |memo, date|
      memo[Ordinal.from_time(date)] = []
      memo
    end
  end

  def self.entries_by_ordinal(dates)
    Entry.ascending.all.reduce(dates) do |memo, entry|
      if memo[entry.ordinal]
        memo[entry.ordinal] << entry
      else
        memo[entry.ordinal] = [entry]
      end
      memo
    end
  end

  def self.populate
    ENTRIES.map do |entry|
      new({
        occurred_at: Date.strptime(entry[:time], "%Y %m %d %A"),
        value: entry[:value],
        category: entry[:type],
      })
    end
  end

  ENTRIES = [
    {
      value: "family time in la",
      time: "2017 10 25 Wednesday",
      type: "family",
    },
    {
      value: "catchup with matt",
      time: "2017 10 25 Wednesday",
      type: "friends",
    },
    {
      value: "work",
      time: "2017 10 25 Wednesday",
      type: "instacart",
    },
    {
      value: "signed up for gym",
      time: "2017 10 26 Thursday",
      type: "gym",
    },
    {
      value: "went to work ",
      time: "2017 10 26 Thursday",
      type: "instacart",
    },
    {
      value: "matz meeting ",
      time: "2017 10 26 Thursday",
      type: "social",
    },
    {
      value: "design meet up. impossible foods was inspiring. brand marketing. put out a brand. enable friends to share message. partner with taste makers/ artists. chefs",
      time: "2017 10 26 Thursday",
      type: "social",
    },
    {
      value: "work",
      time: "2017 10 27 Friday",
      type: "instacart",
    },
    {
      value: "coworker halloween party",
      time: "2017 10 27 Friday",
      type: "social",
    },
    {
      value: "Drinking out on the town with Matt",
      time: "2017 10 27 Friday",
      type: "social",
    },
    {
      value: "grocery shopping",
      time: "2017 10 28 Saturday",
      type: "health",
    },
    {
      value: "cleaning",
      time: "2017 10 28 Saturday",
      type: "cleaning",
    },
    {
      value: "laundry",
      time: "2017 10 28 Saturday",
      type: "cleaning",
    },
    {
      value: "rest",
      time: "2017 10 28 Saturday",
      type: "rest",
    },
    {
      value: "lunch with matt",
      time: "2017 10 29 Sunday",
      type: "friends",
    },
    {
      value: "gym workout ",
      time: "2017 10 29 Sunday",
      type: "gym",
    },
    {
      value: "light work",
      time: "2017 10 29 Sunday",
      type: "instacart",
    },
    {
      value: "date! ",
      time: "2017 10 29 Sunday",
      type: "relationships",
    },
    {
      value: "work",
      time: "2017 10 30 Monday",
      type: "instacart",
    },
    {
      value: "gym",
      time: "2017 10 30 Monday",
      type: "gym",
    },
    {
      value: "held to my diet and ate at home!",
      time: "2017 10 30 Monday",
      type: "health",
    },
    {
      value: "work",
      time: "2017 10 31 Tuesday",
      type: "instacart",
    },
    {
      value: "dodgers game , curb, tv",
      time: "2017 10 31 Tuesday",
      type: "leisure",
    },
    {
      value: "work",
      time: "2017 11 1 Wednesday",
      type: "instacart",
    },
    {
      value: "world series ",
      time: "2017 11 1 Wednesday",
      type: "leisure",
    },
    {
      value: "catch up with aliya east bay spice",
      time: "2017 11 1 Wednesday",
      type: "relationships",
    },
    {
      value: "work",
      time: "2017 11 2 Thursday",
      type: "instacart",
    },
    {
      value: "aliya hang out at home",
      time: "2017 11 2 Thursday",
      type: "relationships",
    },
    {
      value: "work",
      time: "2017 11 3 Friday",
      type: "instacart",
    },
    {
      value: "shadow show with aliya",
      time: "2017 11 3 Friday",
      type: "relationships",
    },
    {
      value: "ordered doordash ",
      time: "2017 11 3 Friday",
      type: "treat",
    },

    {
      value: "gym",
      time: "2017 11 4 Saturday",
      type: "gym",
    },
    {
      value: "damon",
      time: "2017 11 4 Saturday",
      type: "project",
    },


    {
      value: "gym",
      time: "2017 11 5 Sunday",
      type: "gym",
    },
    {
      value: "dinner w/ peter",
      time: "2017 11 5 Sunday",
      type: "social",
    },
    {
      value: "phone call with mom",
      time: "2017 11 5 Sunday",
      type: "family",
    },
    {
      value: "damon",
      time: "2017 11 5 Sunday",
      type: "project",
    },


    {
      value: "damon",
      time: "2017 11 6 Monday",
      type: "project",
    },
    {
      value: "work",
      time: "2017 11 6 Monday",
      type: "instacart",
    },
    {
      value: "phone call with mom",
      time: "2017 11 6 Monday",
      type: "family",
    },
  ]
end
