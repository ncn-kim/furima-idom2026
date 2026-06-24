class ItemsController < ApplicationController
  #ログイン有無確認
  before_action :authenticate_user!
  #destroy実行前に自分の商品か確認
  before_action :authorize_destroy!, only: [:destroy]


  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path
  end

  private
  def authorize_destroy!
    @item = Item.find(params[:id])
    #自分の商品でない場合トップページに
    redirect_to root_path unless @item.owned_by?(current_user)
  end

end
