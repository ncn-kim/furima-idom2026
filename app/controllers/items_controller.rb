class ItemsController < ApplicationController
  # ログイン有無確認
  before_action :authenticate_user!, except: [:index]
  # 商品情報取得
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # ログイン中でも、売却済み+自身の商品以外ならトップページ
  before_action :authorize_edit!, only: [:edit, :update]
  # destroy実行前に自分の商品か確認
  before_action :authorize_destroy!, only: [:destroy]


  def destroy
    @item.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @item.update(item_params)
      # 更新できたら詳細ページに遷移
      redirect_to item_path(@item)
    else
      # 失敗したら
      render :edit, status: :unprocessable_content
    end
  end

  def show
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

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :image, :detail, :price, :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id,
                                 :schedule_id).merge(user_id: current_user.id)
  end

  def authorize_edit!
    # 売却済みならトップページ
    redirect_to root_path if @item.order.present?
    # 他人の商品ならトップページ
    redirect_to root_path unless @item.user_id == current_user.id
  end

  def authorize_destroy!
    # 自分の商品でない場合トップページに
    redirect_to root_path unless @item.owned_by?(current_user)
  end
end
