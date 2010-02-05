class AlbumsController < InheritedResources::Base

  before_filter :require_user 

  def index
    albums = Album.all(:include => :owner)
    @owners_to_albums = albums.group_by(&:owner)
  end

  def show
    show!
  rescue => e
    redirect_to collection_url
  end
  
  def create
    @album = Album.new(params[:album])
    @album.owner = current_user
    create!
  end
  
  def destroy
    if resource.owner != current_user
      flash[:error] = t("albums.destroy.disallowed")
      redirect_to album_url(resource)
    else
      destroy!
    end
  end
end
