require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'user_a', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'user_b', email: 'b@example.com') }

    before do
      FactoryBot.create(:task, name: 'first task', user: user_a)
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end

    context 'when user_a logged in' do
      let(:login_user) { user_a }

      it 'display task belongs to user_a' do
        expect(page).to have_content 'first task'
      end
    end

    context 'when user_b logged in' do
      let(:login_user) { user_b }

      it 'not display task belongs to user_a' do
        expect(page).to have_no_content 'first task'
      end
    end
  end
end
