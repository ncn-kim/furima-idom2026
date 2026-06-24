class ItemsController < ApplicationController
  before_action :move_to_index, except: %i[index]
  def index
    @items = Item.order('created_at DESC')
    # includes(:user) ユーザー管理機能マージ時反映
  end
end
