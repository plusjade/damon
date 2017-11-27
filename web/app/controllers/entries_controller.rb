class EntriesController < ActionController::Base
  def create
    category = Category.find_by_name!(params[:category])
    entry = Entry.new({
      ordinal: params[:ordinal],
      value: params[:value],
      category: category,
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
