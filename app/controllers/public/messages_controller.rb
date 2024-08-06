class Public::MessagesController < ApplicationController
  def create
    @message = current_customer.messages.build(message_params)
    @room = @message.room
    if @message.save
      redirect_to public_room_path(@room), notice: 'メッセージが送信されました。'
    else
      flash.now[:alert] = @message.errors.full_messages.join(", ")
      @messages = @room.messages
      @entries = @room.entries
      @myCustomerId = current_customer.id
      render 'public/rooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id, :customer_id)
  end
end

