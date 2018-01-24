class Prompt < ApplicationRecord
  belongs_to :category

  scope :sorted, -> { order("position asc") }

  def self.populate(category_id)
    category = Category.find(category_id)
    PROMPTS[:promptsObjects].values.map.with_index do |a, i|
      new({
        key: a[:id],
        prompt: a[:prompt],
        custom_prompt: a[:customPrompt],
        choices: a[:choices],
        position: i,
        category_id: category.id,
      })
    end
  end

  PROMPTS = {
    promptsIndex: [
      "where",
      "what",
      "feels",
      "when",
      "custom",
    ],
    promptsObjects: {
      where: {
        id: "where",
        type: "prompt",
        prompt: "Where did you exercise?",
        customPrompt: "Somewhere else...",
        choices: [
          "|custom|",
          "trail",
          "home",
          "gym",
          "outside",
        ],
      },
      what: {
        id: "what",
        type: "prompt",
        prompt: "What did you do?",
        customPrompt: "Something else...",
        choices: [
          "|custom|",
          "bike",
          "yoga",
          "run",
          "weights",
          "cardio",
          "walk",
        ],
      },
      feels: {
        id: "feels",
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
        id: "when",
        type: "prompt",
        prompt: "When was this?",
        customPrompt: "Enter a custom date",
        choices: [
          "Yesterday",
          "Today",
        ]
      },
      custom: {
        id: "custom",
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
