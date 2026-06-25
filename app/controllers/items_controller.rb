class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :detail, :price, :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id,
                                 :schedule_id).merge(user_id: current_user.id)
  end
end
