class FeedsController < ActionController::Base
  def show
    if params[:category_name] == "home"
      feed = home
    else
      feed = Feed.new(category_name: params[:category_name])
      feed = feed.feed
    end

    render json: {
      feed: feed,
    }
  end

  private def home
    [
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
  end
end
