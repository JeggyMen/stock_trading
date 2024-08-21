class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_client

  def dashboard
    @stocks = current_user.stocks
    @transactions = []
    current_user.transactions.order(created_at: :desc).includes(:stock).each do |transaction|
      next if @transactions.select{|a| a[:stock_id] == transaction.stock_id }.present?
      @transactions.push({
        stock_id: transaction.stock_id,
        symbol: transaction.stock.symbol,
        price: transaction.price,
        quantity: transaction.current_quantity,
        total_value: transaction.current_quantity * transaction.price
      })
    end

    @transactions.select!{|a| a[:quantity] > 0}

    @history = current_user.transactions.includes(:stock)
  end

  def history
    @history = current_user.transactions.includes(:stock)
  end

  private

  def authorize_client
    redirect_to root_path unless current_user.trader?
  end
end