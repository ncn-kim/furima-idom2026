class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      # ユーザー管理機能待ち
      t.references :user,       null:false, foreign_key: true
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.integer :category_id, null: false
      t.integer :sales_status_id, null: false
      t.integer :shipping_fee_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :schedule_id, null: false
      t.timestamps
    end
  end
end
