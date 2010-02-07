# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def owns?(obj, user = @current_user)
    return false if obj.nil? || user.nil?
    
    case
    when obj.is_a?(Album)
      obj.owner
    when obj.is_a?(Photo)
      obj.album.owner
    else
      nil
    end == user
  end

  def paperclip_image_tag(image, style_name)
    image_tag image.url(style_name), :width => image.width(style_name), :height => image.height(style_name)
  end
end
