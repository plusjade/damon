class TrendsController < ActionController::Base
  def index
    t = Trends.new

    render json: {
      trends: t.trends,
      days: t.days,
      categories: t.categories
    }
  end
end
