# module Public
  class Public::PostsController < ApplicationController
    before_action :authenticate_customer!

    def index
      @posts = Post.all
    end

    def show
      @post = Post.find(params[:id])
      @game = Game.find(params[:game_id])
    end

    def new
      @game = Game.find(params[:game_id])
      @post = @game.posts.new()
      @customer = current_customer
    end

    def create
      @game = Game.find(params[:game_id])
      @post = @game.posts.new(post_params)
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