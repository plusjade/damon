class TrendsController < ActionController::Base
  def index
    t = Trends.new

    render json: {
      today: {
        ordinal: Ordinal.from_time(Time.now)
      },
      categories: t.trends,
    }
  end
end
