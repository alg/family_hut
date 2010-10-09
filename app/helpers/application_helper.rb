module ApplicationHelper
  def owns?(obj, user = current_user)
    user && user.owns?(obj)
  end

  def paperclip_image_tag(image, style_name)
    image_tag image.url(style_name)
  end
  
  def link_image_to_function(label, class_name, function)
    link_to_function image_tag('1x1.gif', :width => 16, :height => 16), function, :title => label, :class => "action #{class_name}"
  end
end
