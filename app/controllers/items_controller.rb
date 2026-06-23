class ItemsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      puts @item.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :detail, :price, :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id,
                                 :schedule_id)
    #  .merge(user_id: current_user.id)
  end
end
