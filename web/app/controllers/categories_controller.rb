class CategoriesController < ActionController::Base
  def index
    user = User.find(params[:user_id])
    category_list = CategoryList.new(user_id: user.id)

    render json: {
      categories: category_list.payload,
    }
  end
end
