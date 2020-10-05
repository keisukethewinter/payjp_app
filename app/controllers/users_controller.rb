class UsersController < ApplicationController
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id) # ユーザーidを元にカード情報を取得

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token) #上で取得したカード情報(変数"card")を元に顧客情報を取得
    @card = customer.cards.first
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path # 更新できたらトップページへ
    else
      redirect_to "show" # 失敗すれば再度マイページへ
    end
  end

  private

  def user_params
    patams.require(:user).permit(:name, :email)
  end

end
