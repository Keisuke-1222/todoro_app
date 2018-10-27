require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
  let(:admin_user) { create(:admin_user) }
  let(:not_admin_user) { create(:user) }
  let!(:other_user) { create(:user) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログインする'
  end

  describe 'ユーザー一覧' do
    before do
      visit admin_users_path
    end

    context '管理者ユーザーの場合' do
      let(:user) { admin_user }
      it '正常に表示される' do
        expect(page).to have_content admin_user.name
        expect(page).to have_content other_user.name
      end
    end

    context '管理ユーザーでない場合' do
      let(:user) { not_admin_user }
      it 'トップページが表示される' do
        expect(page.current_path).to eq root_path
      end
    end
  end

  describe 'ユーザー詳細' do
    before do
      visit admin_user_path(admin_user.id)
    end

    context '管理ユーザーの場合' do
      let(:user) { admin_user }
      it '正常に表示される' do
        expect(page).to have_content admin_user.name
        expect(page).to have_content admin_user.email
      end
    end

    context '管理ユーザーでない場合' do
      let(:user) { not_admin_user }
      it 'トップページが表示される' do
        expect(page.current_path).to eq root_path
        expect(page).not_to have_content admin_user.name
      end
    end
  end

  describe 'ユーザー登録' do
    before do
      visit new_admin_user_path
    end

    context '管理ユーザーの場合' do
      let(:user) { admin_user }

      before do
        fill_in '名前', with: 'new user'
        fill_in 'メールアドレス', with: 'new_user@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button '登録する'
      end

      it 'ユーザー一覧ページに新規ユーザーが表示されている' do
        expect(page.current_path).to eq admin_users_path
        expect(page).to have_content 'new user'
        expect(page).to have_selector '.alert-success', text: 'new user'
      end
    end

    context '管理ユーザーでない場合' do
      let(:user) { not_admin_user }
      it 'トップページが表示される' do
        expect(page.current_path).to eq root_path
      end
    end
  end
end
