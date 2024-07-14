# module Public
  class Public::CustomersController < ApplicationController

    def index
      @customers = Customer.all
    end

    def show
      @customer = Customer.find(params[:id])
      @posts = @customer.posts
    end

    def edit
    @customer = current_customer
    @post = @customer.posts
    end

    def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
    end

    private
    def customer_params
      params.require(:customer).permit(:email, :name, :introduction, :main_game, :password, :password_confirmation)
    end


  end
# end