class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         enum role: { trader: 'trader', admin: 'admin' }

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :trader
  end
end