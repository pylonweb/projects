$(document).ready(function(){
	$("#slideshow")
	.addClass("galleri_content")
	.wrap('<div id="galleri_content"></div>')
	.parent()
	.wrap('<div id="galleri_container"></div>')
	.parent()
	.prepend('<div id="galleri_clip"></div>')
	.prepend('<div id="galleri_buttons"></div>');
	
	$("#galleri_content .galleri_content > div").addClass("galleri_image");
	
	
	var count = 0
	$("#galleri_content .galleri_image").each(function() {
		count++;
		$(this).addClass("image_"+count).css({position: "absolute"});
		$("#galleri_buttons").prepend("<div id='image_button_"+count+"' class='image_button' data-value='"+count+"'></div>");
	});
	
	$('.image_button').click(function(){
		value = parseInt($(this).attr('data-value'));
		stop_auto(t);
		auto_fade(speed, value);
	});
	
	var t;
	var speed = 5000;
	var animation_speed = 1500;
	var current_image = 0;
	
	if(count > 1){
		auto_fade(speed, 1);
	}else{
		height = parseInt($('#galleri_content').css('width'));
		pos = parseInt($('.image_1').css('width'));
		$('.image_1').css({left: height-pos});
		$('#galleri_buttons').hide();
		$("#image_button_1").addClass("selected");
		$(".image_1").show();
	}
	
	
	function fade(new_image){
		height = parseInt($('#galleri_content').css('width'));
		pos = parseInt($('.image_'+new_image).css('width'));
		$('.image_'+new_image).css({left: height-pos});
		$('.image_'+new_image).fadeIn(animation_speed);
		$(".image_"+current_image).fadeOut(animation_speed);
		
		$("#image_button_"+current_image).removeClass("selected");
		$("#image_button_"+new_image).addClass("selected");
		
		current_image = new_image;
		
	}
	
	function auto_fade(speed, new_image){
		if(new_image > count){
			new_image = 1;
		}
		fade(new_image);
		t = setTimeout(function(){auto_fade(speed, (new_image+1) )}, speed);
	}
	
	function stop_auto(timeout){
		clearTimeout(timeout);
	}
});