class Admins::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
  end

  def comeback
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: !@customer.is_deleted)
    redirect_to admins_posts_path
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: !@customer.is_deleted)

    if @customer.is_deleted
      flash[:notice] = "退会処理を実行いたしました"
    else
      flash[:notice] = "有効にします"
    end
    redirect_to admins_posts_path
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :introduction, :main_game, :is_deleted, :encrypted_password)
  end

end
