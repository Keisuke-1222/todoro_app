require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'user_a', email: 'a@example.com')
      FactoryBot.create(:task, name: 'first task', user: user_a)
    end

    context 'when user_a logged in' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'display task belongs to user_a' do
        expect(page).to have_content 'first task'
      end
    end

    context 'when user_b logged in' do
      before do
        FactoryBot.create(:user, name: 'user_b', email: 'b@example.com')
        visit login_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'not display task belongs to user_a' do
        expect(page).to have_no_content 'first task'
      end
    end
  end
end
