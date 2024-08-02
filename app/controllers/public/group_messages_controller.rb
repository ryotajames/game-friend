class Public::GroupMessagesController < ApplicationController

  def room
  end

  def new
    @room = Room.new
    @group = Group.find(params[:group_id])
    @customer = current_customer

    @group_message = @room.messages.build
    @group_message.customer = current_customer
  end

  def create
    @group_message = GroupMessage.new(message_params)
    @group_message.customer_id = current_customer.id
    @group_message.group_id = params[:group_id].to_i
    if @group_message.save!
      redirect_to group_room_path(params[:group_id].to_i)
    else
    end
  end

  private

  def message_params
    params.require(:group_message).permit(:body)
  end
end

