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
jQuery.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
});

$.fn.selectInstitutionsWithAjax = function() {
  var that = this;

  this.change(function() {
    $.post(that.attr('action'), {state: that.val()}, null, "script");
  });
}

$.fn.selectCampusesWithAjax = function() {
  var that = this;

  this.change(function() {
    $.post(that.attr('action'), {ins: that.val()}, null, "script");
  });
}

$.fn.selectProvincesWithAjax = function() {
  var that = this;
  
  this.change(function() {
    $.post(that.attr('action'), {country_code: that.val(), elem_id: that.parent().attr('id')}, null, "script");
  });
}

$(document).ready(function() {
  $("#selected_institution_state").selectInstitutionsWithAjax();
  $("#institution_select").selectCampusesWithAjax();
  
  $("#deadline-select").datepicker({ dateFormat: "yy-mm-dd" });
})
