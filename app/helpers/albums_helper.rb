module AlbumsHelper

  # Returns the link to a previous photo if present
  def link_to_previous_photo(photo = @photo)
    if Navigator.has_photo_before?(photo)
      link = album_photo_path(photo.album.id, Navigator.photo_id_before(photo))
      content_tag(:div, link_to(h("<< #{t(:previous)}"), link), :class => "prev")
    end
  end

  # Returns the link to a next photo if present
  def link_to_next_photo(photo = @photo)
    if Navigator.has_photo_after?(photo)
      link = album_photo_path(photo.album.id, Navigator.photo_id_after(photo))
      content_tag(:div, link_to(h("#{t(:next)} >>"), link), :class => "next")
    end
  end

end
