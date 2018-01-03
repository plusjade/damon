class FeedsController < ActionController::Base
  def show
    user = User.find(params[:user_id])
    f = Feed.new(user_id: user.id, category_name: params[:category_name])
    feed = f.feed
    chats = get_chats
    render json: {
      chatsIndex: feed.map{ |a| a[:id] } ,
      chatsObjects: (feed + chats).reduce({}) { |memo, a| memo[a[:id]] = a ; memo },
      chatsCommands: [
        {id: chats.first[:id], duration: 2000, delay: 300},
        {id: chats[1][:id], duration: 1600, delay: 1000},
        # {id: 3, duration: 1000, delay: 1000},
        # {id: 4, duration: 800, delay: 1000},
        # {id: 5, duration: 1000, delay: 1000},
        # {id: 6, duration: 800, delay: 1000},
        # {id: 7, duration: 1000, delay: 1000},
        # {id: 8, duration: 1500, delay: 1000},
        # {id: 9, duration: 1500, delay: 2000},
      ],
    }
  end

  private def get_chats
    [
      {
        type: "botEntry",
        value: "Hello there! 👋",
        emoji: "🤖",
        timestamp: Time.now.to_i,
      },
      {
        type: "botEntry",
        value: "I'm positive buddy 🤪",
        timestamp: (Time.now + 10.seconds).to_i,
      },
      {
        type: "botEntry",
        value: "💡💡💡 I'm not that bright....",
        emoji: "",
      },
      {
        type: "botEntry",
        value: "🤔",
        emoji: "",
      },

      {
        type: "botEntry",
        value: "yet!",
        emoji: "",
      },
      {
        type: "botEntry",
        value: "But over time I'll learn more about the world.",
        emoji: "",
      },
      {
        type: "botEntry",
        value: "And help you on your journey.",
        emoji: "",
      },
      {
        type: "botEntry",
        value: "Let's do it! 💪",
        emoji: "",
      },
      {
        type: "botEntry",
        value: "btw, I'm a feminist ^_^",
        emoji: "",
      },
    ].map { |a| a[:id] = Digest::MD5.hexdigest(a[:value]); a }
  end
end
