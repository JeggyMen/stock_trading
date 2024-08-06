class StocksController < ApplicationController
  def index
     @stocks = Stock.all
  end

  def add_to_portfolio
    @stock = Stock.find(params[:id])
    if current_user.stocks.include?(@stock)
      flash[:alert] = 'Stock already in your portfolio.'
    else
      current_user.stocks << @stock
      flash[:notice] = 'Stock added to your portfolio.'
    end
    redirect_to stocks_path
  end
end
