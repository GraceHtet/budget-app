class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:author).where(author: current_user)
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params.merge(author: current_user))

    if @category.save
      redirect_to categories_path, notice: 'A new category was created successfully.'
    else
      render :new, alert: 'An error occurred while creating a new category.'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
