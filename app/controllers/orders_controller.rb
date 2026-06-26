class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index
  def index
    @item = Item.find(params[:item_id])
    @order_delivery_address = OrderDeliveryAddress.new
  end

  def create
    @item = Item.find(params[:item_id])

    @order_delivery_address = OrderDeliveryAddress.new(order_params)

    if @order_delivery_address.valid?
      Payjp.api_key = ENV['TEST_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: @order_delivery_address.token, # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @order_delivery_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end
end
