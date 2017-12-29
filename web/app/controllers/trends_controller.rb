class TrendsController < ActionController::Base
  def index
    t = Trends.new

    f = Feed.new
    feed = f.feed

    #feed = t.days_with_months.map {|a| b = a.dup; b.delete(:entries) ; b }

    feed += [
      {
        type: "botEntry",
        value: "Hello there!",
        emoji: "🤖",
        timestamp: Time.now.to_i,
      },
      {
        type: "botEntry",
        value: "Every day I'm going to ask you 'What did you do today?' " \
               "I'll keep track of all your answers and help you build positive habits.",
        timestamp: Time.now + 10.seconds.to_i,
      },
    ]

    render json: {
      # dict: feed.reduce({}) do |memo, d|
      #   if d[:timestamp]
      #     memo[d[:timestamp]] = d
      #   end
      #   memo
      # end,
      today: {
        ordinal: Ordinal.from_time(Time.now)
      },
      # category_feed: f.category_feed,
      feed: feed,
      categories: t.trends,
    }
  end
end
