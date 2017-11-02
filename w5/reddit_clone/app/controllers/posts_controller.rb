class PostsController < ApplicationController

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create

    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = post_params[:sub_ids].first
    @subs = Sub.all


    if @post.save
      redirect_to sub_post_url(sub_id: @post.sub_id, id: @post.id)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      if @post.update_attributes(post_params)

        redirect_to sub_post_url(@post.sub_id, @post.id)
      else
        flash[:errors] = @post.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["Not your post!"]
      redirect_to subs_url
    end
  end

  def show
    @post = Post.includes(:comments, :author).find_by(id: params[:id])
    @all_comments = @post.comments
    @subs = Sub.all
    render :show
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end


end
