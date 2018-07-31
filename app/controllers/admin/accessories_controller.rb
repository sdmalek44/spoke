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
    if params[:retire] == 'true'
      @accessory.update!(retired?: true)
      flash[:notice] = "Successfully retired #{@accessory.title}"
      redirect_to admin_bike_shop_path
    elsif params[:retire] == 'false'
      @accessory.update(retired?: false)
      flash[:notice] = "Successfully activated #{@accessory.title}"
      redirect_to admin_bike_shop_path
    elsif @accessory.update(accessory_params)
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
    params[:accessory][:image] = 'https://www.hsjaa.com/images/joomlart/demo/default.jpg' unless params[:image]
    params.require(:accessory).permit(:title, :description, :price, :image)
  end
end
