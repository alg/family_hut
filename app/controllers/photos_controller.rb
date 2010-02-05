class PhotosController < InheritedResources::Base

  before_filter :require_user
  before_filter :require_ownership, :only => [ :edit, :update, :destroy ]
  belongs_to :album
  
  def show
    show!
  rescue => e
    redirect_to parent_url
  end
  
  def create
    create! { parent_url }
  end
  
  def create_ten
    @album = Album.find(params[:album_id])
    
    params[:photos][:photos].each do |i, attrs|
      @album.photos << Photo.new(attrs) unless attrs[:image].nil?
    end
    
    redirect_to album_url(@album)
  end
  
  def create_comment
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])

    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    
    if @comment.valid?
      @photo.comments << @comment
      redirect_to album_photo_url(@album, @photo, :anchor => "comments")
    else
      render :show
    end
  rescue => e
    redirect_to parent_url
  end
  
  def update
    update! unless modifications_disallowed?("update")
  end
  
  def destroy
    destroy! { parent_url } unless modifications_disallowed?("delete")
  end
  
  private

  def require_ownership
    if resource.album.owner != current_user
      flash[:error] = i18n_disallowed_message("photos")
      redirect_to album_photo_url(resource.album, resource)
      return false
    end
  end

end
