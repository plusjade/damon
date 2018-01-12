class CategoriesController < ApplicationController

  before_action :authenticate!

  def index
    category_list = CategoryList.new(user_id: current_user.id)

    categories_objects = category_list.payload.reduce({}) { |m, c| m[c[:name]] = c; m }

    render json: {
      categoriesIndex: categories_objects.keys,
      categoriesObjects: categories_objects,
    }
  end
end
