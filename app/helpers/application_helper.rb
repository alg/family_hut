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
    image_tag image.url(style_name) #, :width => image.width(style_name), :height => image.height(style_name)
  end
  
  def link_image_to_function(label, class_name, function)
    link_to_function image_tag('1x1.gif', :width => 16, :height => 16), function, :title => label, :class => "action #{class_name}"
  end
end
