class Public::GroupMessagesController < ApplicationController

  def new
    @room = Room.new
    @group = Group.find(params[:group_id])
    @customer = current_customer

    @group_message = @room.messages.build
    @group_message.customer = current_customer
  end

  def create
    @group = Group.find(params[:group_id])
    @customer = current_customer
    @messages = @group.group_messages
    @group_message = GroupMessage.new
    if @group_message.save
      redirect_to group_room_path(group_id: @group)
    else
      redirect_to group_path(@group)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id, :customer_id, :group_id)
  end
end

