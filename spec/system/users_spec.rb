require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:not_admin_user) { FactoryBot.create(:user) }

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
