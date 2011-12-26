$ ->                       
  editable_titles = $(".photo.editable .title")
  return if editable_titles.length == 0
    
  album_id = $("#album_id").val()
  editable_titles.editable(
    "/albums/" + album_id + "/photos/update_title",
    type: "text",
    name: "title",
    submit: "OK",
    width: 200,
    submitdata: ->
      pid = $(this).parent().attr("pid")
      return { album_id: album_id, id: pid }
  )
