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

  def update
    update! unless modifications_disallowed?(t("albums.update.disallowed"))
  end
  
  def destroy
    destroy! unless modifications_disallowed?(t("albums.destroy.disallowed"))
  end
  
  private
  
  def modifications_disallowed?(message)
    if resource.owner != current_user
      flash[:error] = message
      redirect_to album_url(resource)
      return true
    end
  end
end
