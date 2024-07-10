module Public
  class CustomersController < ApplicationController

    def index
      @customers = Customer.all
    end

    def show
      @customer = Customer.find(params[:id])
    end

    private
    def customer_params
      params.require(:customer).permit(:email, :name, :introduction, :password, :password_confirmation)
    end


  end
end