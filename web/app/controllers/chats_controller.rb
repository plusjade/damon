class ChatsController < ApplicationController
  def index
    category = params[:scat].presence.to_s
    category = (/\A[\w\-]+\z/).match?(category) ? category : "exercise"

    data = home(category)
    chatsObjects = data.reduce({}) { |memo, a| memo[a[:id]] = a ; memo }
    render json: {
      chatsIndex: [],
      chatsObjects: chatsObjects,
      chatsCommands: [
        {id: data[0][:id], duration: 1000, delay: 300},
        {id: data[1][:id], duration: 1600, delay: 1000},
        {id: data[2][:id], duration: 1000, delay: 1400},
        {id: data[3][:id], duration: 1000, delay: 2000},
        {id: data[4][:id], duration: 1000, delay: 1400},
        {id: data[5][:id], duration: 1000, delay: 1000},
      ]
    }
  end

  private def home(category)
    [
      {
        type: "botEntry",
        value: "Hello there! 👋 I'm positive buddy 🤪",
        emoji: "🤖",
      },
      {
        type: "botEntry",
        value: [
          {value: "Jade told me you'd like to track your "},
          {value: category, type: "strong"},
          {value: " habits."},
        ],
      },
      {
        type: "botEntry",
        value: [
          {value: "I can help! ", type: "p"},
          {value: "Just text me stuff whenever, I'll keep track of everything.", type: "p"},
        ],
      },
      {
        type: "botEntry",
        value: "Let's do it! 💪",
      },
      {
        type: "botEntry",
        value: "Please log in with Google so only you can see our chats 😇",
      },
      {
        type: "googleSignIn",
        value: "googleSignIn"
      },
    ].map do |a|
      a[:id] = Digest::MD5.hexdigest(a[:value].to_s)
      a
    end
  end
end
