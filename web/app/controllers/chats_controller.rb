class ChatsController < ApplicationController
  def index
    category = params[:scat].presence.to_s
    category = (/\A[\w\-]+\z/).match?(category) ? category : "exercise"

    chats = Chat.new(category)
    data = chats.payload
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
end
