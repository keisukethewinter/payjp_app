class CardsController < ApplicationController
  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test', #テストカードであることを説明
    　card: params[:card_token]
    )
  end
  
end
