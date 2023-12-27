require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "全ての登録情報が存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicnameが空では登録できない" do
        @user.nickname = " "
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it "emailが空では登録できない" do
        @user.email = " "
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = "tajimagmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end

      it "passwordが空では登録できない" do
        @user.password = " "
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = "01234"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it 'passwordが英数字混合でないと場合登録できない' do
        @user.password = "01234567"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too long (maximum is 128 characters)"
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = "01234567p"
        @user.password_confirmation = "01234567u"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it "first_name_zenkakuが空では登録できない" do
        @user.first_name_zenkaku = " "
        @user.valid?
        expect(@user.errors.full_messages).to include "First name zenkaku can't be blank"
      end

      it "first_name_zenkakuが全角文字でないと登録できない（英字の場合）" do
        @user.first_name_zenkaku = "Terry"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name zenkaku 全角文字（ひらがな、カタカナ、漢字）を使用してください"
      end

      it "first_name_zenkakuが全角文字でないと登録できない（全角英字の場合）" do
        @user.first_name_zenkaku = "Ｔｅｒｒｙ"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name zenkaku 全角文字（ひらがな、カタカナ、漢字）を使用してください"
      end

      it "last_name_zenkakuが空では登録できない" do
        @user.last_name_zenkaku = " "
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name zenkaku can't be blank"
      end

      it "last_name_zenkakuが全角文字でないと登録できない（英字の場合）" do
        @user.last_name_zenkaku = "Smith"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name zenkaku 全角文字（ひらがな、カタカナ、漢字）を使用してください"
      end

      it "last_name_zenkakuが全角文字でないと登録できない（全角英字の場合）" do
        @user.last_name_zenkaku = "Ｓｍｉｔｈ"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name zenkaku 全角文字（ひらがな、カタカナ、漢字）を使用してください"
      end

      it "first_name_katakanaが空では登録できない" do
        @user.first_name_katakana = " "
        @user.valid?
        expect(@user.errors.full_messages).to include "First name katakana can't be blank"
      end

      it "first_name_katakanaが全角カタカナでないと登録できない（英字の場合）" do
        @user.first_name_katakana = "Terry"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name katakana 全角カタカナを使用してください"
      end

      it "first_name_katakanaが全角カタカナでないと登録できない（全角英字の場合）" do
        @user.first_name_katakana = "Ｔｅｒｒｙ"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name katakana 全角カタカナを使用してください"
      end

      it "first_name_katakanaが全角カタカナでないと登録できない（全角かなの場合）" do
        @user.first_name_katakana = "てりい"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name katakana 全角カタカナを使用してください"
      end

      it "first_name_katakanaが全角カタカナでないと登録できない（漢字の場合）" do
        @user.first_name_katakana = "手理伊"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name katakana 全角カタカナを使用してください"
      end

      it "last_name_katakanaが空では登録できない" do
        @user.last_name_katakana = " "
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name katakana can't be blank"
      end

      it "last_name_katakanaが全角カタカナでないと登録できない（英字の場合）" do
        @user.last_name_katakana = "Smith"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name katakana 全角カタカナを使用してください"
      end

      it "last_name_katakanaが全角カタカナでないと登録できない（全角英字の場合）" do
        @user.last_name_katakana = "Ｓｍｉｔｈ"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name katakana 全角カタカナを使用してください"
      end

      it "last_name_katakanaが全角カタカナでないと登録できない（全角かなの場合）" do
        @user.last_name_katakana = "すみす"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name katakana 全角カタカナを使用してください"
      end

      it "last_name_katakanaが全角カタカナでないと登録できない（漢字の場合）" do
        @user.last_name_katakana = "酢美酢"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name katakana 全角カタカナを使用してください"
      end
    end
  end
end