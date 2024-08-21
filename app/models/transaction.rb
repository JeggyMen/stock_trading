class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :transaction_type, inclusion: { in: %w[buy sell] }
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }

  scope :buy_transactions, -> { where(transaction_type: 'buy') }
  scope :sell_transactions, -> { where(transaction_type: 'sell') }
  scope :consolidate, -> { group(:stock_id, :transaction_type) }
  scope :for_user, ->(user) { where(user: user) }
  scope :for_stock, ->(stock) { where(stock: stock) }

  before_create :set_current_quantity

  def updated_quantity
    user.transactions.last.current_quantity
  end

  private

  def set_current_quantity
    last_quantity = user.transactions.where(stock_id: stock_id).last&.current_quantity || 0

    if transaction_type.to_sym == :buy
      self.current_quantity = last_quantity + quantity
    elsif transaction_type.to_sym == :sell
      self.current_quantity = last_quantity - quantity
    end
  end
end
