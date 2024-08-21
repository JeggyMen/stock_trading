class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_trader, only: [:buy, :sell]

  def index
    @stocks = Stock.all
  end

   def add_to_portfolio
    @stock = Stock.find(params[:id])
    quantity = params[:quantity].to_i || 1
    price = params[:price].to_f
    transaction_type = params[:transaction_type]

    if current_user.stocks.exists?(@stock.id)
      flash[:alert] = 'Stock already in your portfolio.'
    else
      current_user.user_stocks.create(stock: @stock)
      flash[:notice] = 'Stock added to your portfolio.'
    end
    redirect_to client_dashboard_path
  end


  def buy
    @stock = Stock.find(params[:id])
    quantity = params[:quantity].to_i

    if quantity <= 0
      flash[:alert] = 'Quantity must be a positive number.'
      redirect_to client_dashboard_path
      return
    end

    if current_user.balance >= @stock.price * quantity
    transaction = Transaction.new(
      user: current_user,
      stock: @stock,
      transaction_type: 'buy',
      quantity: quantity,
      price: @stock.price
    )
      
      if transaction.save
        current_user.update!(balance: current_user.balance - @stock.price * quantity)
        redirect_to client_dashboard_path, notice: "Successfully bought #{quantity} shares of #{@stock.symbol}."
      else
        flash[:alert] = transaction.errors.full_messages.to_sentence
        redirect_to client_dashboard_path
      end
    else
      redirect_to client_dashboard_path, alert: 'Insufficient balance.'
    end
  end

  def sell
    @stock = Stock.find(params[:id])
    transaction = current_user.transactions.buy_transactions.for_stock(@stock).first

    if transaction
      quantity = params[:quantity].to_i
      total_price = @stock.price * quantity
      sell_transaction = Transaction.new(
        user: current_user,
        stock: @stock,
        quantity: params[:quantity],
        price: @stock.price,
        transaction_type: 'sell'
      )
    
      if sell_transaction.save
        current_user.update!(balance: current_user.balance + total_price)
        flash[:notice] = "Successfully sold #{quantity} shares of #{@stock.symbol}."
      else
        flash[:alert] = sell_transaction.errors.full_messages.to_sentence
      end
      else
        flash[:alert] = 'You do not own this stock.'
      end
        redirect_to client_dashboard_path
      end


  private

  def authorize_trader
    redirect_to root_path, alert: 'Not authorized' unless current_user.trader?
  end
end
