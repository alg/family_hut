class AlbumsController < ApplicationController

  before_filter :require_user 

  def index
    albums = Album.all(:include => :owner)
    @owners_to_albums = albums.group_by(&:owner)
  end

  def new
  end
  
  def create
    @album = Album.new(params[:album])
    @album.owner = current_user
    
    if @album.save
      flash[:notice] = "Album was created"
      redirect_to @album
    else
      render :new
    end
  end
  
end
