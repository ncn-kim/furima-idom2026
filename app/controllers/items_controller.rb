class ItemsController < ApplicationController
  #ログアウト時はログインページに
  before_action :authenticate_user!
  #ログイン中でも、売却済み+自身の商品以外ならトップページ
  before_action :authorize_edit!, only: [:edit, :update]


  def edit
    #パラメーターから商品情報取得
    @item = Item.find(params[:id])
  end

  def update
    #パラメーターから商品情報取得
    @item = Item.find(params[:id])

    if @item.update(item_params)
    #更新できたら詳細ページに遷移
      redirect_to item_path(@item)
    else
    #失敗したら
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :detail, :price, :sales_status_id, :category_id, :shipping_fee_id, :prefecture_id, :schedule_id )
  end

  def authorize_edit!
    #パラメーターから商品情報取得
    @item = Item.find(params[:id])

    #売却済みならトップページ
    redirect_to root_path if @item.sold_out?
    
    #他人の商品ならトップページ
    redirect_to root_path unless @item.user_id == current_user.id
  end

end
