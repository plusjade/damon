class PromptSerializer < ActiveModel::Serializer
  attributes :key, :prompt, :choices

  attribute :type do
    "prompt"
  end

  attribute :customPrompt do
    object.custom_prompt
  end
end
