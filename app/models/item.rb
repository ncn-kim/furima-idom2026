class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :schedule
  has_one_attached :image

  # active_hash外のカラムバリデーション
  validates :name, :detail, :price, :image, presence: true
  # active_hash発カラムバリデーション("---"保存不可設定)
  validates :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id, :schedule_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
