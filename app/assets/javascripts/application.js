//= require jquery
//= require jquery.jeditable
//= require jquery.tools.min
//= require ajaxupload
//= require_self
//= require_tree .

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
  var photo = $("<div class='photo placeholder' id='pid_" + placeholder_id + "'><div class='title'>&nbsp;</div><div class='date'>&nbsp;</div><div class='image'><img src='/app_assets/indicator.gif'> Uploading</div></div>");
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
        var csrf_token = $('meta[name=csrf-token]').attr('content'),
            csrf_param = $('meta[name=csrf-param]').attr('content');

        var data = { callback: 'show_uploaded_image', placeholder_id: pid, format: 'js' };
        data[csrf_param] = csrf_token;
    		this.setData(data);
    		pid++;
    	}
    });
  }
});

