class UsersController < ApplicationController
  before_action :shared_header
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @items = @user.items
  end

  private

  def shared_header
    @categories = Category.where.not(id: 1)
    @brands = Brand.all
  end
end
