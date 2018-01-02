class FeedsController < ActionController::Base
  def show
    user = User.find(params[:user_id])
    feed = Feed.new(user_id: user.id, category_name: params[:category_name])
    feed = feed.feed

    render json: {
      feed: feed,
    }
  end
end
