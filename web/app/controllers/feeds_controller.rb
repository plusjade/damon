class FeedsController < ActionController::Base
  def show
    user = User.find(params[:user_id])
    f = Feed.new(user_id: user.id, category_name: params[:category_name])
    feed = f.feed

    render json: {
      chatsIndex: feed.map{ |a| a[:id] } ,
      chatsObjects: (feed + chats).reduce({}) { |memo, a| memo[a[:id]] = a ; memo },
      chatsCommands: [
        {id: 1, duration: 2000, delay: 300},
        # {id: 2, duration: 1600, delay: 1000},
        # {id: 3, duration: 1000, delay: 1000},
        # {id: 4, duration: 800, delay: 1000},
        # {id: 5, duration: 1000, delay: 1000},
        # {id: 6, duration: 800, delay: 1000},
        # {id: 7, duration: 1000, delay: 1000},
        # {id: 8, duration: 1500, delay: 1000},
        # {id: 9, duration: 1500, delay: 2000},
      ],
      feed: feed,
    }
  end

  private def chats
    [
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
    ]
  end
end
