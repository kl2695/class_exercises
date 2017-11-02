class AlbumsController < ApplicationController

  def new
    @bands = Band.all
    render :new
  end

  def create
    @bands = Band.all
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end

  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end




  private

  def album_params
    params.require(:album).permit(:title, :band_id, :year, :live)
  end
end
