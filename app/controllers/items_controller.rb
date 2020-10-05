class ItemsController < ApplicationController
  before_action :find_item, only: :order

  def index
    @items = Item.all
  end

  def order # 購入のためのアクション
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token # ログイン中のユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token, # 上で定義した顧客トークン
      currency: 'jpy'
    )

    ItemOrder.create(item_id: params[:id]) # params(商品id)を"item_id"として保存

    redirect_to root_path
  end

  private

  def find_item
    @item = Item.find(params[:id]) # 購入する商品の特定
  end

end
