class ItemsController < ApplicationController
  # ログイン有無確認
  before_action :authenticate_user!, except: [:index, :show]
  # 商品情報取得
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # ログイン中でも、売却済み+自身の商品以外ならトップページ
  before_action :authorize_edit!, only: [:edit, :update]
  # destroy実行前に自分の商品か確認
  before_action :authorize_destroy!, only: [:destroy]
  # 共有されるheaderのカテゴリを共通化
  before_action :shared_header, only: [:index, :show]

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
    ViewCount.create(item_id: @item.id, user_id: current_user&.id)
  end

  def index
    @items = Item.includes(:user)
    filter_by_category
    filter_by_brand
    filter_by_status
    sort_items
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

  def item_params
    params.require(:item).permit(:name, :image, :detail, :price, :category_id, :brand_id, :sales_status_id, :shipping_fee_id, :prefecture_id,
                                 :schedule_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def shared_header
    @categories = Category.where.not(id: 1)
    @brands = Brand.all
  end

  def authorize_edit!
    # パラメーターから商品情報取得
    @item = Item.find(params[:id])

    # 売却済みならトップページ
    redirect_to root_path if @item.order.present?

    # 他人の商品ならトップページ
    redirect_to root_path unless @item.user_id == current_user.id
  end

  def authorize_destroy!
    # 自分の商品でない場合トップページに
    redirect_to root_path unless @item.owned_by?(current_user)
  end

  def filter_by_category
    return unless params[:category_id].present?

    @category = Category.find(params[:category_id])
    @items = @items.where(category_id: params[:category_id])
  end

  def filter_by_brand
    return unless params[:brand_id].present?

    @brand = Brand.find(params[:brand_id])
    @items = @items.where(brand_id: params[:brand_id])
  end

  def filter_by_status
    return unless params[:status].present?

    @items =
      case params[:status]
      when 'selling'
        @items.left_joins(:order)
              .where(orders: { id: nil })
      when 'sold'
        @items.joins(:order)
      else
        @items
      end
  end

  def sort_items
    @items =
      case params[:sort]
      when 'view_count_desc'
        @items.left_joins(:view_counts)
              .group(:id)
              .order('COUNT(view_counts.id) DESC')

      when 'view_count_asc'
        @items.left_joins(:view_counts)
              .group(:id)
              .order('COUNT(view_counts.id) ASC')

      when 'price_desc'
        @items.order(price: :desc)

      when 'price_asc'
        @items.order(price: :asc)

      else
        @items.order(created_at: :desc)
      end
  end
end
