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
    
end
