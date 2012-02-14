//= require jquery
//= require jquery.jeditable
//= require jquery.tools.min
//= require jquery_ujs
//= require ajaxupload
//= require bootstrap-twipsy
//= require bootstrap-popover
//= require_self
//= require_tree .

function show_uploaded_image(placeholder_id, photo_id, title, date, brief_url, photo_url) {
  var img = $("<img></img>").attr("src", brief_url);
  var link = $("<a></a>").attr("href", photo_url).append(img);
  var ph = $("#pid_" + placeholder_id);
  ph.find(".title").text(title);
  ph.find(".image").text('').append(link);
  ph.removeClass("placeholder");
}

function generate_uploading_placeholder(placeholder_id) {
  var photo = $("<div class='photo placeholder span5' id='pid_" + placeholder_id + "'><div class='image'><img src='/app_assets/indicator.gif'> Uploading</div><div class='title'>&nbsp;</div></div>");
  photo.insertAfter("#photos .placeholder.upload");
}

$(function() {
  //$("img[rel]").overlay();
  $("img[rel='popover']").popover({ placement: 'below' });

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

