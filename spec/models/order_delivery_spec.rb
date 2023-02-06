require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '発送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id)
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
        expect(@order_delivery.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_delivery.postcode = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it 'region_idを選択していないと保存できないこと' do
        @order_delivery.region_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Region can't be blank")
      end
      it 'municipalityが空だと保存できないこと' do
        @order_delivery.municipality = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'house_numberが空だと保存できないこと' do
        @order_delivery.house_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁以上11桁以内の半角数値を含んだ形式でないと保存できないこと' do
        @order_delivery.phone_number = '123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
