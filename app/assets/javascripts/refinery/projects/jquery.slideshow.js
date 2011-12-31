$(document).ready(function(){
	$("#slideshow_content")
	.addClass("slideshow_content")
	.wrap('<div id="slideshow_clip"></div>')
	.parent()
	.wrap('<div id="slideshow_container"></div>')
	.parent()
	.append('<div id="slideshow_buttons"></div>');
	
	$('#slideshow_buttons')
	.prepend('<div id="slideshow_left"></div>')
	.prepend('<div id="slideshow_right"></div>');
	
	$('#slideshow_left').html('&lt;');
	$('#slideshow_right').html('&gt;');
	
	var width = 0;
	$("#slideshow_content > .project_images").each(function(){
		width += parseInt($(this).css('width')) + parseInt($(this).css('margin-left'));
	});
	$("#slideshow_content").css({width: width});
	
	width -= parseInt($('#slideshow_clip').css('width'));
	
	var speed = 3;
	
	$('div#slideshow_left').mousedown(function(){
		start_slideshow(false);
	});
	
	$('div#slideshow_right').mousedown(function(){
		start_slideshow(true);
	});
	
	$('body').mouseup(function(){
		end_slideshow();
	});
	
	$('div#slideshow_left').mouseleave(function(){
		end_slideshow();
	});
	
	$('div#slideshow_right').mouseleave(function(){
		end_slideshow();
	});
	
	$('#slideshow_clip').mousewheel(function(event, delta) {
		event.preventDefault();
	  wheel_slideshow(delta*speed*5);
	});
	
	var start_slideshow = function(direction) {		
		pos = parseInt($('#slideshow_content').css('left'));	
		
		if(width < 0){
			change = 0;
			animation = 0;
		}else if(direction){
			change = -(width + pos);
			animation = -(speed * change);
		}else {
			change = - pos;
			animation = speed * change;
		}
		$('.slideshow_content').animate({left: pos + change}, animation, 'linear');
	}
	
	var end_slideshow = function() {
		$('.slideshow_content').stop(true,false);
	}
	
	var wheel_slideshow = function(change) {
		pos = parseInt($('.slideshow_content').css('left'));
		if(width < 0){
			change = 0;
		}else if(pos + change > 0){
			change = -pos;
		}else if(pos + change < -width){
			change = -width - pos;
		}
				
		$('.slideshow_content').css({left: pos + change});
	}
});