//= require "jquery/jquery.tools.min"

function show_uploaded_image(placeholder_id, photo_id, title, date, brief_url, photo_url) {
  var img = $("<img></img>").attr("src", brief_url);
  var link = $("<a></a>").attr("href", photo_url).append(img);
  var ph = $("#pid_" + placeholder_id);
  ph.find(".title").text(title);
  ph.find(".date").text(date);
  ph.find(".image").text('').append(link);
  ph.removeClass("placeholder");
}

function generate_uploading_placeholder(placeholder_id) {
  var photo = $("<div class='photo placeholder' id='pid_" + placeholder_id + "'><div class='title'>&nbsp;</div><div class='date'>&nbsp;</div><div class='image'><img src='/images/indicator.gif'> Uploading</div></div>");
  photo.insertAfter("#photos .placeholder.upload");
}

$(function() {
  $("img[rel]").overlay();

  var link  = $('#photos .placeholder a');
  if (link.length > 0) {
    var pid = 1;
    var aid = link.attr('album_id');
    image_upload = new AjaxUpload(link, {
      action: '/albums/' + aid + '/photos',
      name: 'photo[image]',
      responseType: 'json',

    	onSubmit: function(file , ext) {
    	  generate_uploading_placeholder(pid);
    		this.setData({ callback: 'show_uploaded_image', placeholder_id: pid, format: 'js', authenticity_token: window._token });
    		pid++;
    	}
    });
  }
});

