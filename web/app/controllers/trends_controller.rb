class TrendsController < ActionController::Base
  def index
    t = Trends.new

    render json: {
      feed: t.days_with_months.map {|a| b = a.dup; b.delete(:entries) ; b },
      trends: t.trends,
      categories: t.categories
    }
  end
end
