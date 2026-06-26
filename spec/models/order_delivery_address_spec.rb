require 'rails_helper'

RSpec.describe OrderDeliveryAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)

    @order_delivery_address = FactoryBot.build(
      :order_delivery_address,
      user_id: @user.id,
      item_id: @item.id
    )

    sleep 0.1
  end

  describe '購入機能' do
    context '購入できる場合' do
      it 'すべての項目が正しく入力されていれば購入できる' do
        expect(@order_delivery_address).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @order_delivery_address.building = ''
        expect(@order_delivery_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'userが紐付いていないと保存できない' do
        @order_delivery_address.user_id = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できない' do
        @order_delivery_address.item_id = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が空だと購入できない' do
        @order_delivery_address.postal_code = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンがないと購入できない' do
        @order_delivery_address.postal_code = '1234567'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Postal code is invalid')
      end

      it '都道府県を選択しないと購入できない' do
        @order_delivery_address.prefecture_id = 1
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Prefecture must be selected')
      end

      it '市区町村が空だと購入できない' do
        @order_delivery_address.city = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと購入できない' do
        @order_delivery_address.address = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと購入できない' do
        @order_delivery_address.phone_number = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下だと購入できない' do
        @order_delivery_address.phone_number = '123456789'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が12桁以上だと購入できない' do
        @order_delivery_address.phone_number = '123456789111'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が数字以外を含むと購入できない' do
        @order_delivery_address.phone_number = '000-1234-567'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では購入できない' do
        @order_delivery_address.token = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages)
          .to include("Token can't be blank")
      end
    end
  end
end
