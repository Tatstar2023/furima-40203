require 'rails_helper'

RSpec.describe OrderShipment, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipment = FactoryBot.build(:order_shipment, user_id: user.id, item_id: item.id)
  end

  describe '購入する' do
    context '購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipment).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_shipment.building_name = ''
        expect(@order_shipment).to be_valid
      end
    end

    context '購入できない場合' do
      it 'tokenが空では購入できない' do
        @order_shipment.token = nil
        @order_shipment.valid?
        expect(@order_shipment.errors.full_messages).to include "Token can't be blank"
      end
      it 'postcodeが空では購入できない' do
        @order_shipment.postcode = ' '
        @order_shipment.valid?
        expect(@order_shipment.errors.full_messages).to include "Postcode can't be blank"
        expect(@order_shipment.errors.full_messages).to include 'Postcode is invalid. Include hyphen(-)'
      end
      it 'postcodeに-(ハイフン)がないと購入できない' do
        @order_shipment.postcode = '123456'
        @order_shipment.valid?
        expect(@order_shipment.errors.full_messages).to include 'Postcode is invalid. Include hyphen(-)'
      end
      it 'prefectureが空では購入できない' do
        @order_shipment.prefecture_id = 0
        @order_shipment.valid?
        expect(@order_shipment.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'cityが空では購入できない' do
        @order_shipment.city = ' '
        @order_shipment.valid?
        expect(@order_shipment.errors.full_messages).to include "City can't be blank"
      end
      it 'house_numberが空では購入できない' do
        @order_shipment.house_number = ' '
        @order_shipment.valid?
        expect(@order_shipment.errors.full_messages).to include "House number can't be blank"
      end
      it 'telephoneが空では購入できない' do
        @order_shipment.telephone = ' '
        @order_shipment.valid?
        expect(@order_shipment.errors.full_messages).to include "Telephone can't be blank"
        expect(@order_shipment.errors.full_messages).to include 'Telephone is the wrong length (should be 11 characters)'
        expect(@order_shipment.errors.full_messages).to include 'Telephone is invalid. Input only number'
      end
    end
  end
end
