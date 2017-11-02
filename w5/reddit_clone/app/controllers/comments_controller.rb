class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @post = Post.find_by(id: params[:post_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = comment_params[:post_id]
    @subs = Sub.all


    if @comment.save
      redirect_to sub_post_url(sub_id: @comment.post.sub, id: @comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
      @comment = Comment.find_by(id: params[:id])

      render :show
  end



  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
