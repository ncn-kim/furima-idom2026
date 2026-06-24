class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end
end
