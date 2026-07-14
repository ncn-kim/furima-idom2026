class TopController < ApplicationController
  def index
    @items = Item.includes(:user).order(created_at: :desc)
    @categories = Category.where.not(id: 1)
    @brands = Brand.where.not(id: 1)
    ranking
  end

  private

  def ranking
    @all_ranks = Item.joins(:view_counts).group(:item_id).order('count(item_id) desc').limit(5)
  end
end
