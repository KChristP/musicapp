class AlbumsController < ApplicationController

  def create
    album_params
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
    first_params = params.require(:album).permit(:name, :band, :recording_style)
    band_id = Band.find_by(name: first_params[:name])
  end

end
