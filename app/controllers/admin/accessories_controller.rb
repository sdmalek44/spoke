class Admin::AccessoriesController < Admin::BaseController
  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    if @accessory.save
      flash[:notice] = "Successfully created #{@accessory.title}"
      redirect_to accessory_path(@accessory)
    else
      flash[:notice] = "Accessory not created. Try again."
      render :new
    end
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image)
  end
end
