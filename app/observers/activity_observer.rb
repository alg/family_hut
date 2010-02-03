class ActivityObserver < ActiveRecord::Observer

  observe :album, :photo, :comment
  
  def after_create(obj)
    send("#{obj.class.name.downcase}_created", obj)
  rescue => e
    puts e.inspect
    RAILS_DEFAULT_LOGGER.debug "Failed to log #{obj.class.name.downcase} creation:\n#{e.inspect}"
  end
  
  private
  
  def album_created(album)
    log(album.owner, "activity.album.created", {
      :album_id => album.id, :album_name => album.name })
  end
  
  def photo_created(photo)
    album = photo.album
    ll = Log.last
    
    activity = "activity.photo.created"
    data = {
      :album_id => album.id, :album_name  => album.name,
      :photo_id => photo.id, :photo_title => photo.title }
      
    if ll.user != album.owner || ll.activity != activity || ll.data[:album_id] != album.id
      log(album.owner, activity, data)
    end
  end
  
  def comment_created(comment)
    photo = comment.commentable
    album = photo.album
    log(comment.user, "activity.comment.created", {
      :album_id => album.id,      :album_name       => album.name,
      :photo_id => photo.id,      :photo_title      => photo.title,
      :comment_id => comment.id,  :comment_comment  => comment.comment })
  end
  
  def log(user, activity, data)
    Log.create!(:user => user, :activity => activity, :data => data)
  end
end
