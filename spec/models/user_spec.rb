require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'emailに@がないと登録できない' do
        @user.email = 'kkkgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '重複したemailが存在すれば登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordが6文字以下であれば登録できない' do
        @user.password = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードに英数字を含めてください')
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードに英数字を含めてください')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードに英数字を含めてください')
      end
      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it '名字が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字を入力してください')
      end
      it '名前が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください')
      end
      it '名字は全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字を全角文字で入力してください')
      end
      it '名前は全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.last_name = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を全角文字で入力してください')
      end
      it 'フリガナ（名字）が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字のカナを入力してください')
      end
      it 'フリガナ（名前）が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前のカナを入力してください')
      end
      it '名字のフリガナは全角（カタカナ）でなければ登録できない' do
        @user.first_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字のカナを全角文字で入力してください')
      end
      it '名前のフリガナは全角（カタカナ）でなければ登録できない' do
        @user.last_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前のカナを全角文字で入力してください')
      end
      it '生年月日が空だと登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
