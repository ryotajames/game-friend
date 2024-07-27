class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post = @post
    @comments = Comment.all
    if @comment.save
      Rails.logger.debug("Comment saved successfully: #{@comment.inspect}")
      redirect_to post_path(@post), notice: 'コメントが作成されました'
    else
      Rails.logger.debug("Comment failed to save: #{@comment.errors.full_messages}")
      flash.now[:alert] = 'コメントの作成に失敗しました'
      render 'public/posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :customer_id)
  end
end
