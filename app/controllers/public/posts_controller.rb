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

    def edit
      @post = Post.find(params[:id])
      is_matching_login_customer
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to post_path(@post)
      else
        render :new
      end
      is_matching_login_customer
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to public_posts_path
    end

    def is_matching_login_customer
      @customer = current_customer
      @post = Post.find(params[:id])
      customer = @post.customer
      unless customer.id == current_customer.id
        redirect_to post_path(@post)
      end
    end

    private

    def post_params
      params.require(:post).permit(:image, :post_introduction)
    end
  end
# end