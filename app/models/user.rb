class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { trader: 'trader', admin: 'admin' }

  after_initialize :set_default_role, if: :new_record?
  after_create :set_pending_status
  before_update :check_approval
  before_destroy :prevent_admin_deletion

  private

  def set_default_role
    self.role ||= :trader
  end

  def set_pending_status
    self.update_column(:approved, false) if trader?
  end

  def check_approval
    if approved_changed?(from: false, to: true)
      # Perform any additional actions when a user is approved
    end
  end


  def prevent_admin_deletion
    if role == 'admin'
      errors.add(:base, "Admin users cannot be deleted")
      throw :abort
    end
  end
end