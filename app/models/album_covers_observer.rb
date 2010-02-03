class AlbumCoversObserver < ActiveRecord::Observer

  observe :photo

  def after_create(photo)
    album = photo.album
    if album.cover_photo_id.nil?
      album.cover_photo = photo
      album.save
    end
  end

  def after_destroy(photo)
    album = photo.album
    if album.cover_photo_id == photo.id
      album.cover_photo = album.photos.with_image.first
      album.save
    end
  end
  
end
