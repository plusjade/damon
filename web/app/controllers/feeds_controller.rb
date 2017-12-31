class FeedsController < ActionController::Base
  def show
      feed = Feed.new(category_name: params[:category_name])
      feed = feed.feed

    render json: {
      feed: feed,
    }
  end
end
