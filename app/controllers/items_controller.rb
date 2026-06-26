class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_item, except: [:index, :new, :create]
  before_action :move_to_index, only: [:edit, :update]
  def show
    @item = Item.find(params[:id])
    # @comment = Comment.new
    # @comments = @item.comments.includes(:user)
  end

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

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

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :detail, :price, :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id,
                                 :schedule_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user == @item.user && @item.order.blank?
  end
end
