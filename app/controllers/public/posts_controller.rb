# module Public
  class Public::PostsController < ApplicationController
    before_action :authenticate_customer!, only: [:index]

    def index
      @posts = Post.all
      @customer = current_customer
    end

    def show
      @post = Post.find(params[:id])
      @comment = Comment.new
      @comments = Comment.all
    end

    def new
      @post = Post.new
      @customer = current_customer
    end

    def create
      @post = Post.new(post_params)
      @post.customer = current_customer
      if @post.save
        redirect_to about_path, notice: '正常に投稿されました。'
      else
        render :new
      end
    end

    private

    def post_params
      params.require(:post).permit(:image, :post_introduction)
    end
  end
# end