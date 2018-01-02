class EntriesController < ActionController::Base
  def create
    user = User.find(params[:user_id])
    ordinal = params[:ordinal].presence || Ordinal.from_time(Time.now)
    entry = Entry.new({
      user_id: user.id,
      ordinal: ordinal,
      value: params[:value],
    })

    entry.save!

    render json: {
      entry: EntrySerializer.new(entry),
      category: entry.category.name
    }
  end

  def destroy
    user = User.find(params[:user_id])
    entry = Entry.where(user_id: user.id).find(params[:id])
    entry.destroy
    render json: {entry: entry}
  end
end
