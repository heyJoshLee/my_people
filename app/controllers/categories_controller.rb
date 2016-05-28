class CategoriesController < ApplicationController

  before_filter :require_user, only: [:new, :create]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
    
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Your Category was created."
      redirect_to category_path(@category)
    else
      flash[:danger] = "Something went wrong wand your category was not created."
      render :new
    end
    
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end