class PhotosController < InheritedResources::Base

  before_filter :require_user
  belongs_to :album
  
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
  
  def destroy
    destroy! { parent_url }
  end

end
