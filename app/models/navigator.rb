class Navigator < ActiveRecord::Observer

  # Photo sort order within the album. Shared between this class and other places
  # the photos are displayed.
  SORT_ORDER = "id desc"
  
  observe :photo
  
  # Invoked on photo upload. Clear the cache.
  def after_create(photo)
    invalidate_cache_for(photo.album)
  end
  
  # Invoked on photo destroying. Clear the cache.
  def after_destroy(photo)
    invalidate_cache_for(photo.album)
  end
  
  # Returns TRUE if the photo has one after the one given.
  def self.has_photo_after?(photo)
    photo && photo.album && album_photo_ids(photo.album).last != photo.id
  end

  # Returns the ID of the photo after the given.
  def self.photo_id_after(photo)
    photo_id_with_delta(photo, 1)
  end
  
  # Returns TRUE if the photo has one before the one given.
  def self.has_photo_before?(photo)
    photo && photo.album && album_photo_ids(photo.album).first != photo.id
  end

  # Returns the ID of the photo after the given.
  def self.photo_id_before(photo)
    photo_id_with_delta(photo, -1)
  end

  private
  
  def self.photo_id_with_delta(photo, delta)
    return nil if photo.nil? || photo.album.nil?

    ids = album_photo_ids(photo.album)
    idx = ids.index(photo.id) + delta
    return idx >= 0 ? ids[idx] : nil
  end
  
  # Returns the ordered list of photo IDs in a given album. Cached.
  def self.album_photo_ids(album)
    Rails.cache.fetch(album_key(album), :expires_is => 1.hour) do
      album.photos.all(:select => "id", :order => SORT_ORDER).map(&:id)
    end
  end

  # Invalidates the cache of photo IDs for a given album.
  def invalidate_cache_for(album)
    Rails.cache.delete(Navigator.album_key(album))
  end
  
  def self.album_key(album)
    "album:#{album.id}:photo_ids"
  end
  
end
