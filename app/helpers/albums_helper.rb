module AlbumsHelper

  # Returns the link to a previous photo if present
  def link_to_previous_photo(photo = @photo)
    previous_photo_id = photo && photo.album.previous_photo_id(photo)
    label, link = '&nbsp;', '#'
    if previous_photo_id
      label, link = t("previous").html_safe, album_photo_path(photo.album.id, previous_photo_id)
    end
    content_tag(:div, link_to(label.html_safe, link).html_safe, :class => "prev")
  end

  # Returns the link to a next photo if present
  def link_to_next_photo(photo = @photo)
    next_photo_id = photo && photo.album.next_photo_id(photo)
    label, link = '&nbsp;', '#'
    if next_photo_id
      label, link = t("next").html_safe, album_photo_path(photo.album.id, next_photo_id)
    end
    content_tag(:div, link_to(label.html_safe, link).html_safe, :class => "next")
  end

end
