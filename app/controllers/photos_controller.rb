class PhotosController < InheritedResources::Base

  before_filter :require_user
  before_filter :require_ownership, :only => [ :edit, :update, :destroy, :new, :new_ten, :create, :create_ten ]
  belongs_to :album
  
  def show
    show!
  rescue => e
    redirect_to parent_url
  end
  
  def create
    create! do |format|
      format.js   { render 'create', :layout => false }
      format.html { redirect_to parent_url }
    end
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
  
  def update_title
    text   = params[:title]
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])
  
    text = @photo.title
    @photo.title = params[:title]
    if @photo.save
      puts '------------------ saved'
      text = @photo.title
    end
  ensure
    render :text => text, :layout => false
  end
  
  def destroy
    destroy! { parent_url }
  end
  
  private

  def require_ownership
    if parent.owner != current_user
      flash[:error] = i18n_disallowed_message("photos")
      redirect_to album_photo_url(resource.album, resource)
      return false
    end
  end

end
