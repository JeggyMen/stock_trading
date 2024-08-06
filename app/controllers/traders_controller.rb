class TradersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_approval, except: :pending_approval

  def pending_approval
  end

  private

  def check_approval
    unless current_user.approved == 1
      redirect_to pending_approval_path, alert: "Your account is not approved yet."
    end
  end
end