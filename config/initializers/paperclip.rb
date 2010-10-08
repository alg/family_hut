Paperclip.interpolates :photo_id do |attachment, style|
  i = attachment.instance
  i.is_a?(Album) ? i.cover_photo_id : i.id
end
