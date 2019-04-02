// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).ready(function(){
	$(document).find('.task-comments-container').hide()

	$('.like-btn').click(function() {
		var taskId = this.dataset.taskId;
		var userId = this.dataset.userId;

		$.ajax({
	     type: "POST",// GET in place of POST
	     contentType: "application/json; charset=utf-8",
	     url: "/likes/like_post",
	     data : JSON.stringify({like: {task_id: taskId, user_id: userId}}),
	     dataType: "json",
	     success: function (response) {
	     	if (response && response.status === 200){
	     		if (response.like && response.like === true)
	        	this.children[0].setAttribute('src', '/assets/like.png');
	        else
	        	this.children[0].setAttribute('src', '/assets/unlike.png');

        	this.children[1].innerHTML = response.like_count;

	     	}   		

	     }.bind(this),
	     error: function (){
	        window.alert("something wrong!");
	     }
		});
	});

  $('.comments-icon').click(function(){
  	$($(this).parents().eq(2).find('.task-comments-container')).toggle();
  })

  $('#add-comment-btn').click(function() {
  	alert(this);
  	var taskId = this.dataset.taskId;

  	$.ajax({
	     type: "GET",// GET in place of POST
	     contentType: "application/json; charset=utf-8",
	     url: "/comments/list",
	     data : JSON.stringify({task_id: taskId}),
	     dataType: "json",
	     success: function (response) {
	     	if (response && response.status === 200){

	     	}   		

	     }.bind(this),
	     error: function (){
	        window.alert("something wrong!");
	     }
	   });
  })

});