require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { email: user.email, password: 'password' } }

  before do
    post login_path, params: { session: valid_params }
  end

  describe "GET /tasks" do
    it "works! (now write some real specs)" do
      get tasks_path
      expect(response).to have_http_status(200)
    end
  end
end
