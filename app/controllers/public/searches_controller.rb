class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "ユーザー"
      @customers = Customer.looks(params[:search], params[:word])
    elsif @range == "グループ"
      @groups = Group.looks(params[:search],params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end