class FeedsController < ActionController::Base
  def show
    user = User.find(params[:user_id])
    feed = Feed.new(user_id: user.id, category_name: params[:category_name])
    feed = feed.feed

    feed.insert(2,
      {
        id: 1,
        type: "botEntry",
        value: "Hello there! 👋",
        emoji: "🤖",
        timestamp: Time.now.to_i,
      })

    feed.insert(5,
      {
        id: 1,
        type: "botEntry",
        value: "Hello there! 👋",
        emoji: "🤖",
        timestamp: Time.now.to_i,
      })

    feed.insert(10,
      {
        id: 1,
        type: "botEntry",
        value: "Hello there! 👋",
        emoji: "🤖",
        timestamp: Time.now.to_i,
      })

    feed.insert(15,
      {
        id: 1,
        type: "botEntry",
        value: "Hello there! 👋",
        emoji: "🤖",
        timestamp: Time.now.to_i,
      })

    feed =     [
      {
        id: 1,
        type: "botEntry",
        value: "Hello there! 👋",
        emoji: "🤖",
        timestamp: Time.now.to_i,
      },
      {
        id: 2,
        type: "botEntry",
        value: "I'm positive buddy 🤪",
        timestamp: (Time.now + 10.seconds).to_i,
      },
      {
        id: 3,
        type: "botEntry",
        value: "💡💡💡 I'm not that bright....",
        emoji: "",
      },
      {
        id: 4,
        type: "botEntry",
        value: "🤔",
        emoji: "",
      },

      {
        id: 5,
        type: "botEntry",
        value: "yet!",
        emoji: "",
      },
      {
        id: 6,
        type: "botEntry",
        value: "But over time I'll learn more about the world.",
        emoji: "",

      },
      {
        id: 7,
        type: "botEntry",
        value: "And help you on your journey.",
        emoji: "",
      },
      {
        id: 8,
        type: "botEntry",
        value: "Let's do it! 💪",
        emoji: "",
      },
      {
        id: 9,
        type: "botEntry",
        value: "btw, I'm a feminist ^_^",
        emoji: "",
      },
    ] + feed

    render json: {
      feed: feed,
    }
  end
end
