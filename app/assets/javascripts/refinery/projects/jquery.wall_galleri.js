$(document).ready(function(){
	$("#wall_content")
	.addClass("wall_content")
	.wrap('<div id="wall_clip"></div>')
	.parent()
	.wrap('<div id="wall_container"></div>')
	.parent()
	.append('<div id="wall_buttons"></div>');
	
	$('#wall_buttons')
	.prepend('<div id="wall_left"></div>')
	.prepend('<div id="wall_right"></div>');
	
	$('#wall_left').html('&lt;');
	$('#wall_right').html('&gt;');
	
	var width = 0;
	$("#wall_content > .project_images").each(function(){
		width += parseInt($(this).css('width')) + parseInt($(this).css('margin-left'));
	});
	// $("#wall_content").css({width: width});
	
	width -= parseInt($('#wall_clip').css('width'));
	
	var speed = 3;
	
	$('div#wall_left').mousedown(function(){
		start_wall(false);
	});
	
	$('div#wall_right').mousedown(function(){
		start_wall(true);
	});
	
	$('body').mouseup(function(){
		end_wall();
	});
	
	$('div#wall_left').mouseleave(function(){
		end_wall();
	});
	
	$('div#wall_right').mouseleave(function(){
		end_wall();
	});
	
	$('#wall_clip').mousewheel(function(event, delta) {
		event.preventDefault();
	  wheel_wall(delta*speed*5);
	});
	
	var start_wall = function(direction) {		
		pos = parseInt($('#wall_content').css('left'));	
		
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
		$('.wall_content').animate({left: pos + change}, animation, 'linear');
	}
	
	var end_wall = function() {
		$('.wall_content').stop(true,false);
	}
	
	var wheel_wall = function(change) {
		pos = parseInt($('.wall_content').css('left'));
		if(width < 0){
			change = 0;
		}else if(pos + change > 0){
			change = -pos;
		}else if(pos + change < -width){
			change = -width - pos;
		}
				
		$('.wall_content').css({left: pos + change});
	}
});