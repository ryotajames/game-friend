class Public::GroupMessagesController < ApplicationController

  def new
    @room = Room.new
    @group = Group.find(params[:group_id])
    @message = @room.messages.build(message_params)
    @message.customer = current_customer
  end

  def create
  end

  private
  def message_params
    params.require(:message).permit(:body, :room_id, :group_messages)
  end

end
