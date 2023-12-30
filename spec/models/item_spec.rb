require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品する' do
    context '出品できる場合' do
      it '全ての情報が入力されれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'titleが空では出品できない' do
        @item.title = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include "Title can't be blank"
      end

      it 'descriptionが空では出品できない' do
        @item.description = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end

      it 'category_idが空では出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it 'condition_idが空では出品できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end

      it 'shippingfee_idが空では出品できない' do
        @item.shippingfee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Shippingfee can't be blank"
      end

      it 'shippingorigin_idが空では出品できない' do
        @item.shippingorigin_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Shippingorigin can't be blank"
      end

      it 'shippingleadtime_idが空では出品できない' do
        @item.shippingleadtime_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Shippingleadtime can't be blank"
      end

      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end

      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it 'priceが空では出品できない' do
        @item.price = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end

      it 'priceが数字以外では出品できない（漢字の場合）' do
        @item.price = '値段'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end

      it 'priceが数字以外では出品できない（ひらがなの場合）' do
        @item.price = 'ねだん'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end

      it 'priceが数字以外では出品できない（カタカナの場合）' do
        @item.price = 'ネダン'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end

      it 'priceの値が300より小さい場合出品できない' do
        @item.price = 290
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end
      it 'priceの値が9999999より大きい場合出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end
    end
  end
end
