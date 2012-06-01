// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

jQuery(document).ready(function() {

  jQuery.fn.content_count_down = function() {
    var content_size = jQuery('#micropost_content').val().length;
    var difference = 140 - content_size;
    var display_message = 'Now You can type ' + difference + ' characters';
    jQuery('#content_text').html(display_message);
  }

  jQuery(this).content_count_down();
    
  jQuery('#micropost_content').keyup(function(){
    jQuery(this).content_count_down();
  })

  /*jQuery('#micropost_content').keydown(function(){
    jQuery(this).content_count_down();
  })

jQuery('.delete-post').click(function(){
  jQuery.ajax({
    type: "DELETE",
    url: jQuery(this).href(),
    dataType: 'json',
    success: function(data) {
      jQuery('#feed_item_list').html(data);
    }
  });
});*/

})