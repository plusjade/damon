class TrendsController < ActionController::Base
  def index
    t = Trends.new
    feed = t.days_with_months.map {|a| b = a.dup; b.delete(:entries) ; b }
    feed += [
      {
        type: "botEntry",
        value: "Hello there!",
        emoji: "🤖",
      },
      {
        type: "botEntry",
        value: "Every day I'm going to ask you 'What did you do today?' " \
               "I'll keep track of all your answers and help you build positive habits.",
      },
      # {
      #   type: "botEntry",
      #   value: "I'm still training, so you'll have to help me group your answers by using hashtags.",
      # },

      # {
      #   type: "botEntry",
      #   value: "I'm not yet smart enough to give you advice on how to achieve specific goals. " \
      #          "But there's one thing I know everyone has to do if they want to get better at anything.",
      # },
      # {
      #   type: "botEntry",
      #   value: "show up",
      # },
      # {
      #   type: "botEntry",
      #   value: "Achieving anything is applying sustained effort over time. The more you show up, the more progress you'll make.",
      # },
    ]

    render json: {
      today: {
        ordinal: Ordinal.from_time(Time.now)
      },
      feed: feed,
      categories: t.trends,
    }
  end
end
