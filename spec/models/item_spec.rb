require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報入力' do
    context '商品情報入力ができる場合' do
      it '全ての値が正しく入力されていれば出品できること' do
        expect(@item).to be_valid
      end
    end
    context '商品情報入力がうまくできない場合' do
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'nameが空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'descriptionが空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'categoryが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it 'conditionが未選択だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品状態を選択してください")
      end
      it 'shipping_feeが未選択だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it 'regionが未選択だと出品できない' do
        @item.region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it 'delivery_timeが未選択だと出品できない' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日時を選択してください")
      end
      it 'priceが空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it 'priceが300円以下だと出品できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
      end
      it 'priceが9,999,999円以下だと出品できない' do
        @item.price = 999_999_999
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
