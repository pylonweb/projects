$(document).ready(function(){
	$("#body_content")
	.addClass("scroll_content")
	.wrap('<div id="scroll_clip"></div>')
	.parent()
	.wrap('<div id="scroll_container"></div>')
	.parent()
	.prepend('<div id="scroll_buttons"></div>');
	
	$('#scroll_buttons')
	.prepend('<div id="scroll_up"></div>')
	.prepend('<div id="scroll_down"></div>');
	
	$('#scroll_up').html('&or;');
	$('#scroll_down').html('&and;');
	
	var speed = 3;
	var height = parseInt($('.scroll_content').css('height')) - parseInt($('#scroll_clip').css('height'));
	
	$('div#scroll_up').mousedown(function(){
		start_scroll(true);
	});
	
	$('div#scroll_down').mousedown(function(){
		start_scroll(false);
	});
	
	$('body').mouseup(function(){
		end_scroll();
	});
	
	$('div#scroll_up').mouseleave(function(){
		end_scroll();
	});
	
	$('div#scroll_down').mouseleave(function(){
		end_scroll();
	});
	
	$('#scroll_clip').mousewheel(function(event, delta) {
		event.preventDefault();
	  wheel_scroll(delta*speed*5);
	});
	
	var start_scroll = function(direction) {		
		pos = parseInt($('.scroll_content').css('top'));	
		
		if(height < 0){
			change = 0;
			animation = 0;
		}else if(direction){
			change = -(height + pos);
			animation = -(speed * change);
		}else {
			change = - pos;
			animation = speed * change;
		}
			
		$('.scroll_content').animate({top: pos + change}, animation, 'linear');
	}
	
	var end_scroll = function() {
		$('.scroll_content').stop(true,false);
	}
	
	var wheel_scroll = function(change) {
		pos = parseInt($('.scroll_content').css('top'));
		if(height < 0){
			change = 0;
		}else if(pos + change > 0){
			change = -pos;
		}else if(pos + change < -height){
			change = -height - pos;
		}
				
		$('.scroll_content').css({top: pos + change});
	}
});