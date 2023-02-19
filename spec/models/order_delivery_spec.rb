require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '発送先情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_delivery.building_name = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できないこと' do
        @order_delivery.postcode = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_delivery.postcode = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号にハイフンを含めてください")
      end
      it 'region_idを選択していないと保存できないこと' do
        @order_delivery.region_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("都道府県を選択してください")
      end
      it 'municipalityが空だと保存できないこと' do
        @order_delivery.municipality = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numberが空だと保存できないこと' do
        @order_delivery.house_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが9桁以下では購入できない' do
        @order_delivery.phone_number = '123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号をハイフンなしで10桁以上or11桁以内で入力してください")
      end
      it 'phone_numberが12桁以上では購入できない' do
        @order_delivery.phone_number = '1234567890123'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号をハイフンなしで10桁以上or11桁以内で入力してください")
      end
      it 'phone_numberに半角数字以外が含まれている場合は購入できない' do
        @order_delivery.phone_number = '12345１２３４５'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号をハイフンなしで10桁以上or11桁以内で入力してください")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Itemを入力してください")
      end
      it 'tokenが空では登録できないこと' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
