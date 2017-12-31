class EntriesController < ActionController::Base
  def create
    ordinal = params[:ordinal].presence || Ordinal.from_time(Time.now)
    entry = Entry.new({
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
    entry = Entry.find(params[:id])
    entry.destroy
    render json: {entry: entry}
  end
end
