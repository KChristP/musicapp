class AlbumsController < ApplicationController

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to bands_url
    else
      flash.now[:album_errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :recording_style)
  end

end
