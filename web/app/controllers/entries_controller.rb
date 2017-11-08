class EntriesController < ActionController::Base
  def create
    entry = Entry.new({
      ordinal: params[:ordinal],
      value: params[:value],
      category: params[:category],
    })

    entry.save!

    render json: {entry: entry}
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy
    render json: {entry: entry}
  end
end
