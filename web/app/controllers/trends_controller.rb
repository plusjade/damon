class TrendsController < ActionController::Base
  def index
    t = Trends.new

    render json: {
      trends: t.trends,
      days: t.days_with_months,
      categories: t.categories
    }
  end
end
