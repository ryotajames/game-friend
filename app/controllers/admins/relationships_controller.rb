class Admins::RelationshipsController < ApplicationController

  def followings
    @customer = Customer.find(params[:id])
    @customers = @customer.followings
  end

  def followers
    @customer = Customer.find(params[:id])
    @customers = @customer.followers
  end

end
