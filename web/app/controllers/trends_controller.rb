class TrendsController < ActionController::Base
  def index
    t = Trends.new

    render json: {
      today: {
        ordinal: Ordinal.from_time(Time.now)
      },
      feed: t.days_with_months.map {|a| b = a.dup; b.delete(:entries) ; b },
      categories: t.trends,
    }
  end
end
