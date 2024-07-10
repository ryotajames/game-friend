class Public::SessionsController < ApplicationController
  def destroy
    sign_out(current_customer)
    redirect_to root_path, notice: "ログアウトしました。"
  end
end
