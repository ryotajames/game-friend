# module Public
  class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!

    def index
      @customers = Customer.all
      # @post = Post.find(params[:id])
      @game = Game.all
    end

    def show
      @customer = Customer.find(params[:id])
      @posts = @customer.posts
      @games = Game.all

      @currentCustomerEntry=Entry.where(customer_id: current_customer.id)
      @customerEntry=Entry.where(customer_id: @customer.id)
      if @customer.id == current_customer.id
      else
        @currentCustomerEntry.each do |cu|
          @customerEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end


    def edit
      @customer = current_customer
      @post = @customer.posts
      is_matching_login_customer
    end

    def update
      @customer = current_customer
      if @customer.update(customer_params)
        redirect_to customer_path(@customer), notice: "You have updated user successfully."
      else
        render "edit"
      end
      is_matching_login_customer
    end

    def check

    end

    def withdraw
      @customer = current_customer
      @customer.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    end

    def is_matching_login_customer
      @customer = current_customer
      customer = Customer.find(params[:id])
      unless customer.id == current_customer.id
        redirect_to customer_path(@customer)
      end
    end

    private
    def customer_params
      params.require(:customer).permit(:email, :name, :introduction, :main_game, :password, :password_confirmation, :profile_image)
    end


  end
# end