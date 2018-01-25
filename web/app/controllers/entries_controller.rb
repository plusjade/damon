class EntriesController < ApplicationController
  before_action :authenticate!

  def create
    ordinal = params[:ordinal].presence || Ordinal.from_time(Time.now)
    if ordinal == "yesterday"
      ordinal = Ordinal.from_time(1.day.ago)
    end

    category = nil
    category_name = params[:category].to_s.strip.downcase.presence
    category_name = nil if category_name == "all"
    category_name ||= "uncategorized"
    category = Category.find_or_create_by!(name: category_name, user: current_user)
    raise ActiveRecord::RecordNotFound unless category

    entry = Entry.new({
      user_id: current_user.id,
      category: category,
      ordinal: ordinal,
      value: params[:value],
    })

    entry.save!

    render json: {
      entry: EntrySerializer.new(entry),
      category: entry.category.name
    }
  end

  def update
    entry = Entry.where(user_id: current_user.id).find(params[:id])

    category = nil
    category_name = params[:category].to_s.strip.downcase.presence
    category_name = nil if category_name == "all"
    category_name ||= "uncategorized"
    category_name = Category.normalize_name(category_name)
    category = Category.find_or_create_by!(name: category_name, user: current_user)
    raise ActiveRecord::RecordNotFound unless category

    entry.category = category
    entry.save!

    render json: {
      entry: EntrySerializer.new(entry),
      category: entry.category.name
    }
  end

  def destroy
    entry = Entry.where(user_id: current_user.id).find(params[:id])
    entry.destroy
    render json: {entry: entry}
  end
end
