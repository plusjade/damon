class ChatsController < ActionController::Base
  def index
    render json: {
      chatsIndex: [1],
      chatsObjects: home.reduce({}) { |memo, a| memo[a[:id]] = a ; memo },
      chatsCommands: [
        # {id: 1, duration: 500, delay: 300},
        {id: 2, duration: 800, delay: 1000},
        {id: 3, duration: 800, delay: 1000},
        {id: 4},
        {id: 5},
        {id: 6},
        {id: 7},
      ]
    }
  end

  private def home
    [
      {
        id: 1,
        type: "botEntry",
        value: "Hello there! 👋",
        emoji: "🤖",
        timestamp: Time.now.to_i,
        type: "theirs",
      },
      {
        id: 2,
        type: "botEntry",
        value: "Every day I'm going to ask you 'What did you do today?' " \
               "I'll keep track of all your answers and help you build positive habits.",
        timestamp: Time.now + 10.seconds.to_i,
        type: "theirs",
      },
      {
        id: 3,
        type: "botEntry",
        value: "This is a new message YAY \o/",
        emoji: "",
        type: "theirs",
      },
      {
        id: 4,
        type: "botEntry",
        value: "Sup sup sup",
        emoji: "",
        type: "theirs",
      },
      {
        id: 5,
        type: "botEntry",
        value: "...",
        emoji: "",
        type: "theirs",
      },
      {
        id: 6,
        type: "botEntry",
        value: "meep meep meep!",
        emoji: "",
        type: "theirs",
      },
      {
        id: 7,
        type: "botEntry",
        value: "-_________-",
        emoji: "",
        type: "theirs",
      },
    ]
  end
end
