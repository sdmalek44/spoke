class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end
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

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory = Accessory.find(params[:id])
    if @accessory.update(accessory_params)
      flash[:notice] = "Successfully updated #{@accessory.title}"
      redirect_to accessory_path(@accessory)
    else
      flash[:notice] = "Accessory not updated. Try again."
      render :edit
    end
  end

  def destroy
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image)
  end
end
