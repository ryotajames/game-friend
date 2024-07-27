class Public::GroupsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]

  def index
    @post = Post.new
    @groups = Group.all
    @customer = current_customer
  end

  def show
    # @post = Post.new
    @group = Group.find(params[:id])
    @customer = Customer.find(params[:id])
    @messages = @group.messages.includes(:customer).order(created_at: :asc)
    # @message = @group.messages.new
    @group_customer = GroupCustomer.where(customer_id: @customer, group: @group).last
    @group_customers = GroupCustomer.where(group: @group).pluck(:customer_id)
    
    @room = Room.new
    @entry = Entry.new
    
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_customer.id
    if @group.save
      redirect_to groups_path
    else
      render "new"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

    private

    def group_params
      params.require(:group).permit(:group_name, :main_game, :beginning, :group_image)
    end

    def ensure_correct_customer
      @group = Group.find(params[:id])
      unless @group.owner_id == current_customer.id
        redirect_to groups_path
      end
    end

end
