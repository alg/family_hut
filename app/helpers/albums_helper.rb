module AlbumsHelper

  # Returns the link to a previous photo if present
  def link_to_previous_photo(photo = @photo)
    previous_photo_id = photo && photo.album.previous_photo_id(photo)
    if previous_photo_id
      link = album_photo_path(photo.album.id, previous_photo_id)
      content_tag(:div, link_to(h("<<"), link), :class => "prev")
    end
  end

  # Returns the link to a next photo if present
  def link_to_next_photo(photo = @photo)
    next_photo_id = photo && photo.album.next_photo_id(photo)
    if next_photo_id
      link = album_photo_path(photo.album.id, next_photo_id)
      content_tag(:div, link_to(h(">>"), link), :class => "next")
    end
  end

end
