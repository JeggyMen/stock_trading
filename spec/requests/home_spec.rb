require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:user) { create(:user) } 

  before do
    sign_in user
  end

  describe "GET /index" do
    context "when the user is an admin" do
      before do
        user.update(role: 'admin')
      end

      it "redirects to the admin dashboard" do
        get home_index_path
        expect(response).to have_http_status(:found) 
        expect(response).to redirect_to(admin_authenticated_root_path)
      end
    end

    context "when the user is an approved trader" do
      before do
        user.update(role: 'trader', approved: true) 
      end

      it "redirects to the trader dashboard" do
        get home_index_path
        expect(response).to have_http_status(:found) 
        expect(response).to redirect_to(client_dashboard_path)
      end
    end

    context "when the user is a pending trader" do
      before do
        user.update(role: 'trader', approved: false) 
      end

      it "redirects to the pending approval page" do
        get home_index_path
        expect(response).to have_http_status(:found) 
        expect(response).to redirect_to(pending_approval_path)
      end
    end
  end
end
