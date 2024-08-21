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
  after_create :send_welcome_email
  after_create :send_pending_approval_email
  before_update :send_approval_email, if: :approved_changed?
  after_initialize :set_default_balance, if: :new_record?

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :transactions

  def remaining_quantity
    record = {}

    user.stocks.each do |stock|
      buy_quantity = consolidated_transactions[[stock.id, 'buy']] || 0
      sell_quantity = consolidated_transactions[[stock.id, 'sell']] || 0
      record[stock.id] = buy_quantity - sell_quantity
    end
    puts "record: #{record}"
    record
  end
  
  private

  def set_default_role
    self.role ||= :trader
  end

  def set_pending_status
    update_column(:approved, false) if trader?
  end

  def check_approval
    if approved_changed?(from: false, to: true)
    end
  end


  def prevent_admin_deletion
    if role == 'admin'
      errors.add(:base, "Admin users cannot be deleted")
      throw :abort
    end
  end
  
  def send_welcome_email
    login_url = 'http://rufustrade.com/login'
    UserMailer.welcome_email(self, login_url).deliver_later
   end

   def send_pending_approval_email
    UserMailer.pending_approval_email(self).deliver_later
  end

  def send_approval_email
    if self.approved && self.approved_changed?
      UserMailer.approval_email(self).deliver_later
    end
  end

  def set_default_balance
    self.balance ||= 5000.0
  end
end