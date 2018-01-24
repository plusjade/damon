class Chat
  attr_reader :category

  def initialize(category)
    @category = category
  end

  def payload
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
