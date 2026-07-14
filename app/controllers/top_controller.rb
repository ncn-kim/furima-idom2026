class TopController < ApplicationController
  def index
    @items = Item.includes(:user).order(created_at: :desc)
    @categories = Category.where.not(id: 1)
    @brands = Brand.where.not(id: 1)
    ranking
  end

  private

  def ranking
    @all_ranks = Item
                 .left_joins(:order)
                 .joins(:view_counts)
                 .where(orders: { id: nil })
                 .group(:id)
                 .order('COUNT(view_counts.id) DESC')
                 .limit(5)
  end
end
