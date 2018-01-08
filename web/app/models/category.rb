class Category < ApplicationRecord
  has_many :entries
  belongs_to :user

  PROMPTS = {
    promptsIndex: [
      "where",
      "what",
      "feels",
      "when",
      "freeform",
    ],
    promptsObjects: {
      where: {
        tag: "where",
        type: "prompt",
        prompt: "Where did you get physical?",
        customPrompt: "Somewhere else...",
        choices: [
          "|custom|",
          "Trail",
          "Home",
          "Gym",
          "Outside",
          "Forest",
          "Friends",
        ],
      },
      what: {
        tag: "what",
        type: "prompt",
        prompt: "What did you do?",
        customPrompt: "Something else...",
        choices: [
          "|custom|",
          "I biked",
          "I did Yoga",
          "I ran",
          "I lifted Weights",
          "Cardio",
          "I swam",
        ],
      },
      feels: {
        tag: "feels",
        type: "prompt",
        prompt: "How did you feel?",
        customPrompt: "Something else...",
        choices: [
          "|custom|",
          "😀",
          "😅",
          "😐",
          "😣",
          "😥",
          "😵",
        ],
      },
      when: {
        tag: "when",
        type: "prompt",
        prompt: "When was this?",
        customPrompt: "Enter a custom date",
        choices: [
          "Yesterday",
          "Today",
        ]
      },
      freeform: {
        tag: "freeform",
        type: "prompt",
        prompt: "Anything else?",
        customPrompt: "Something you'd like to remember...",
        choices: [
          "|custom|",
          "|pass|",
        ]
      },
    }
  }
end
