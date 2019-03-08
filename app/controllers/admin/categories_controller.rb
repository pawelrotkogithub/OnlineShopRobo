class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_path, notice: "Pomyślnie dodano kategorie"
    else
      render action: :new
    end
  end


  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path, notice: "Pomyślnie zakutalizowano kategorię"
    else
      render action: :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: "Pomyślnie usunięto kategorie"
  end



  private

  def category_params
    params.require(:category).permit(:name)
  end

end
