require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /client" do
    it "returns http success" do
      get client_dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end