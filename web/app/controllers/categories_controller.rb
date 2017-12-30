class CategoriesController < ActionController::Base
  def index
    category_list = CategoryList.new

    render json: {
      categories: category_list.payload,
    }
  end
end
