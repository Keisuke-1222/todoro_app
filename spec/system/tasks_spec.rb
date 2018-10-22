require 'rails_helper'

describe 'task managemant function', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'user_a', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'user_b', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: 'first task', user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'display task belongs to user_a' do
    it { expect(page).to have_content 'first task' }
  end

  describe 'task index' do
    context 'when user_a logged in' do
      let(:login_user) { user_a }

      it_behaves_like 'display task belongs to user_a'
    end

    context 'when user_b logged in' do
      let(:login_user) { user_b }

      it 'not display task belongs to user_a' do
        expect(page).to have_no_content 'first task'
      end
    end
  end

  describe 'task show' do
    context 'when user_a logged in' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'display task belongs to user_a'
    end
  end

  describe 'task create' do
    let(:login_user) { user_a }
    let(:task_name) { 'task_1' }

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context 'when task_name is inputed' do
      it 'normally registered' do
        expect(page).to have_selector '.alert-success', text: 'task_1'
      end
    end

    context 'when task_name is not inputed' do
      let(:task_name) { '' }

      it 'returns errors' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end
