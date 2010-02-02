class LoggerObserver < ActiveRecord::Observer

  observe :album, :photo, :comment
  
  def after_create(obj)
    send("#{obj.class.name.downcase}_created", obj)
  rescue => e
    RAILS_DEFAULT_LOGGER.debug "Failed to log #{obj.class.name.downcase} creation:\n#{e.inspect}"
  end
  
  private
  
  def album_created(album)
    log(album.owner, "Created album", link_to(album.name, album_path(album)))
  end
  
  def photo_created(photo)
    album = photo.album
    log_no_duplicate(album.owner, "Uploaded photos to album", link_to(album.name, album_path(album)))
  end
  
  def comment_created(comment)
    photo = comment.commentable
    album = photo.album
    photo_link = link_to(photo.title, photo_path(photo))
    album_link = link_to(album.name, album_path(album))
    log(album.owner, "Commented on photo", "#{photo_link} from album #{album_link}:<div class='body'>#{comment.comment}</div>")
  end
  
  def log_no_duplicate(user, activity, target)
    ll = Log.last
    log(user, activity, target) if ll.user != user || ll.activity != activity || ll.target != target
  end
  
  def log(user, activity, target)
    Log.create!(:user => user, :activity => activity, :target => target)
  end
  
  def link_to(label, path)
    "<a href='#{path}'>#{label}</a>"
  end
  
  def album_path(album)
    "/albums/#{album.to_param}"
  end
  
  def photo_path(photo)
    album = photo.album
    "#{album_path(album)}/photos/#{photo.to_param}"
  end
end
