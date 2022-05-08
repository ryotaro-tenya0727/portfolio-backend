require 'rails_helper'

RSpec.describe '推しメン登録機能 Api::V1::Users::RecommendedMembers', type: :request do
  describe 'ユーザーが推しメンを閲覧 GET api/v1/user/recommended_members' do
    context '正常系' do
      it '推しメンを閲覧できること' do

      end
    end
  end

  describe 'ユーザーが推しメンを作成 POST api/v1/user/recommended_members' do
    context '正常系' do
      it '推しメンが新規作成されること' do

      end
    end

    context '異常系' do
      it 'ニックネームが未入力の場合、推しメンが作成されないこと' do

      end
    end
  end

  describe 'ユーザーが推しメンを編集 PUT /api/v1/user/recommended_members/:uuid' do
    context '正常系' do
      it '推しメンを編集できること' do

      end
    end

    context '異常系' do
      it 'ニックネームが未入力の場合、推しメンを編集できないこと' do

      end
    end
  end

  describe 'ユーザーが推しメンを削除 DELETE api/v1/user/recommended_members' do
    context '正常系' do
      it '推しメンを削除できること' do

      end
    end
  end
end
