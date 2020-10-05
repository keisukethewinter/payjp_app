class UsersController < ApplicationController
  def show
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
