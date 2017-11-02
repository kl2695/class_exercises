class SubsController < ApplicationController

  before_action :require_logged_in

  def new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.creator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    @posts = @sub.posts
    render :show
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub
      if @sub.update_attributes(sub_params)
        redirect_to sub_url(@show)
      else
        flash[:errors] = @sub.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["Not your sub!"]
      redirect_to subs_url
    end
  end

  private
  def sub_params
      params.require(:sub).permit(:title, :description)
  end
end
