class CategoriesController < ActionController::Base
  def index
    user = User.find(params[:user_id])
    category_list = CategoryList.new(user_id: user.id)

    categories_objects = category_list.payload.reduce({}) { |m, c| m[c[:name]] = c; m }

    render json: {
      categoriesIndex: categories_objects.keys,
      categoriesObjects: categories_objects,
    }
  end
end
