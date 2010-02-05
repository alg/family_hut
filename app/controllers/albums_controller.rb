class AlbumsController < InheritedResources::Base

  before_filter :require_user
  before_filter :require_ownership, :only => [ :edit, :update, :destroy ]

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

  private
  
  def require_ownership
    if resource.owner != current_user
      flash[:error] = i18n_disallowed_message("albums")
      redirect_to album_url(resource)
      return true
    end
  end
  
end
