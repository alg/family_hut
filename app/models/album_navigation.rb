module AlbumNavigation
  
  # Returns the ID of the previous photo.
  def previous_photo_id(photo)
    photo_id_with_delta(photo, -1)
  end
  
  # Returns the ID of the next photo.
  def next_photo_id(photo)
    photo_id_with_delta(photo, 1)
  end

  private
  
  # Invalidates the cache of photo IDs.
  def invalidate_photo_ids_cache
    @album_photo_ids = nil
    Rails.cache.delete(album_photo_ids_key)
  end

  # Returns the next / previous photo ID based on the delta.
  def photo_id_with_delta(photo, delta)
    return nil if photo.nil? || photo.album_id != self.id
    idx = album_photo_ids.index(photo.id) + delta
    return idx >= 0 ? album_photo_ids[idx] : nil
  end
  
  # Returns the ordered list of photo IDs. Cached.
  def album_photo_ids
    @album_photo_ids ||= Rails.cache.fetch(album_photo_ids_key, :expires_in => 1.hour) do
      self.photos.all(:select => "id").map(&:id)
    end
  end
  
  def album_photo_ids_key
    "album:#{self.id}:photo_ids"
  end
  
end