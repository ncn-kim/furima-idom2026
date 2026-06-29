class TopController < ApplicationController
  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end
end
