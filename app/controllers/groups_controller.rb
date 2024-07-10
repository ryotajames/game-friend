class GroupsController < ApplicationController
  before_action :authentivate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  
  def inded
    @post = Post.new
    @groups = Group.all
    @customer = Custoemr.find(current_customer.id)
  end
  
  def show
    @post = Post.new
    @group = Group.find(params[:id])
    @customer = Customer.find(params[:id])
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render "edit"
    end
  end
    
    private
    def group_params
      params.require(:group).permit(:name, :introduction, :group_image)
    end
    
    def ensure_correct_customer
      @group = Gropu.find(params[:id])
      unless @group.owner_id == current_customer.id
        redirect_to groups_path
      end
    end
  
end
