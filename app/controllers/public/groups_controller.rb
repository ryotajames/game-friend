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
    # @messages = @group.messages.includes(:customer).order(created_at: :asc)
    # @message = @group.messages.new
    @group_customer = GroupCustomer.where(customer_id: @customer, group: @group).last
    @group_customers = GroupCustomer.where(group: @group).pluck(:customer_id)

    @room = Room.new
    @entry = Entry.new

    group_member_ids = @group.customers.pluck(:id) # グループに所属しているユーザーのIDを取得
    @other_customers = Customer.where.not(id: group_member_ids) # それらを除外して他のユーザーを取得


  end

  def new
    @customer = Customer.find(params[:customer_id])
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_customer.id
    if @group.save
      @group.customers << current_customer
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

  def room
    @group = Group.find(params[:group_id])
    @customer = current_customer
    @group_messages = @group.group_messages
    @group_message = GroupMessage.new
  end

  def join
    @group = Group.find(params[:id])
        # @team.users に、current_user のレコードが含まれていなければ以下の処理を行う。
      unless @group.customers.include?(current_customer)
          # @team.users に、current_user のレコードを追加する。
        @team.customers << current_customer
            # 招待通知を検索して削除。
        notification = Notification.find_by(visited_id: current_customer.id, group_id: @group.id, action_type: 4)
        notification.destroy
      end
    redirect_to group_path(@group), notice: "グループに参加しました。"
  end

  def invitation
    @group = Group.find(params[:group_id])
    @customer = Customer.find(params[:customer][:customer_id])
    notification = Notification.where(visited_id: @customer.id, group_id: @group.id, action_type: 4)
    unless notification.exists?
      @group.team_invitation_notification(current_customer, @customer.id, @group.id)
      redirect_to request.referer, notice: "招待を送りました。"
    else
      redirect_to request.referer, alert: "すでに招待しています。"
    end
  end

  def join
    @group = Group.find(params[:group_id])
    # @team.users に、current_user　のレコードが含まれていなければ以下の処理を行う。
    unless @group.customers.include?(current_customer)
# @team.users に、current_user のレコードを追加する。
      @group.customers << current_customer
      # 招待通知を検索して削除。
      notification = Notification.find_by(visited_id: current_customer.id, group_id: @group.id, action: "invitation")
      notification.destroy
    end
    redirect_to group_path(@group), notice: "チームに参加しました。"
  end


    private

    def set_group
      @group = Group.find(params[:id])
    end

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
