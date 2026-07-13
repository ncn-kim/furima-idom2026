class TopController < ApplicationController
  def index
    @items = Item.includes(:user).order(created_at: :desc)
    @categories = Category.where.not(id: 1)
    @brands = Brand.where.not(id: 1)
  end
end
