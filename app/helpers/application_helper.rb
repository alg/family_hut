# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  EMPTY_ALBUM_IMAGE_URL = "/images/empty_album.jpg"
  
  # Returns the thumbnail for an album
  def album_image_url(album)
    (album && album.thumbnail_url) || EMPTY_ALBUM_IMAGE_URL
  end

  def owns?(obj, user = @current_user)
    return false if obj.nil? || user.nil?
    
    case
    when obj.is_a?(Album)
      obj.owner
    when obj.is_a?(Photo)
      obj.album.owner
    else
      nil
    end == @current_user
  end
end
