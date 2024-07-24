class Public::GroupmassegesController < ApplicationController
  before_action :set_group

  def create
    @message = @group.group_messages.new(message_params)
    @message.customer = current_customer

    if @message.save
      redirect_to @group
    else
      render 'groups/show'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:group_message).permit(:message)
  end
end
