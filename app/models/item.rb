class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :schedule

  belongs_to :user
  # has_many :comments
  has_one :order, dependent: :destroy

  has_one_attached :image

  # active_hash外のカラムバリデーション
  validates :name, presence: true, length: { maximum: 40 }
  validates :detail, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  # active_hash発カラムバリデーション("---"保存不可設定)
  validates :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id, :schedule_id,
            numericality: { other_than: 1, message: 'must be selected' }
end
