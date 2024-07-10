module Public
  class PostsController < ApplicationController
    before_action :authenticate_customer!

    def index
      @posts = Post.all
    end

    def new
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to about_path, notice: '正常に投稿されました。'
      else
        render :new
      end
    end

    private

    def post_params
      params.permit(:post_introduction, :image, :customer_id)
    end
  end
end