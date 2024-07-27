class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.customer = current_customer

    if @message.save
      redirect_to room_path(@room), notice: 'メッセージが送信されました'
    else
      Rails.logger.debug "Message params: #{message_params.inspect}"
      Rails.logger.debug "Message errors: #{@message.errors.full_messages.inspect}"
      flash.now[:alert] = @message.errors.full_messages.to_sentence
      render 'rooms/show'
    end
    # @group = Group.find(params[:group_id])
    # @message = @group.messages.build(message_params)

    # if @message.save
    #   redirect_to public_group_path(@group), notice: 'Message sent.'
    # else
    #   redirect_to public_group_path(@group), alert: 'Failed to send message.'
    # end
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id )
  end
end
