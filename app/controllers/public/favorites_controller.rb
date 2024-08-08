class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.new(post: @post)

    if @favorite.save
      redirect_to @post, notice: 'いいねしました'
    else
      logger.error @favorite.errors.full_messages.join(", ")
      redirect_to post_path(params[:post_id]), alert: 'いいねに失敗しました'
    end
  
  post.create_nofitication_like!(current_customer)
  
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.find_by(post: @post)

    if @favorite.destroy
      redirect_to @post, notice: 'いいねを解除しました'
    else
      logger.error @favorite.errors.full_messages.join(", ")
      redirect_to @post, alert: 'いいね解除に失敗しました'
    end
  end

  def new
  end

end
