jQuery(document).ready(function(){
	
	$(".more_production").slides({
		 generatePagination: false,
		 generateNextPrev: true
	});

	$('.example a').click(function(){
		var stext = $(this).html();
		$(this).parents('.search').find('input[type=text]').val(stext);
	});

	$('.mitem a').click(function(){
		$('.submenu').slideUp();
		$('.mitem').removeClass('on');
		if ($(this).attr('rel')) {
			var i = $(this).attr('rel');
			$(this).parent().toggleClass('on');
			$('#sub' + i).slideToggle();
			return false;
		}
	});

	$('.submenu .close a').click(function(){
		$('.submenu').slideUp();
		$('.mitem').removeClass('on');
		return false;
	});

	$('body').click(function(){
		$('.submenu').slideUp();
		$('.mitem').removeClass('on');
	});

	$('.dostavka_but').click(function(){
		$('.dostavka_but').removeClass('active');
		$(this).addClass('active');
	});

	$('.photo td a').click(function(){
		$('.pop').show();
		$('.lightbox').show();
		$('.modal').hide();
		var dataId = $(this).attr('data-id');
		$('.slider_image .slide_image').removeClass('current');
		$('.slider_image .slide_image').eq(parseInt(dataId)-1).addClass('current');
		return false;
	});

	$('.photo li a').click(function(){
		$('.pop').show();
		$('.lightbox').show();
		$('.modal').hide();
		var dataId = $(this).attr('data-id');
		$('.slider_image .slide_image').removeClass('current');
		$('.slider_image .slide_image').eq(parseInt(dataId)-1).addClass('current');
		return false;
	});

	$('.modal .close, .modal .continue').live('click', function(){
		$('.modal').hide();
		$('.pop').hide();
		$('.lightbox').hide();
		$("html,body").css("overflow","auto");
	});

	$('.pop_bg').live('click', function(){
		$('.modal .close, .modal .continue').click();
		$('.pop').hide();
		$('.modal2').remove();
	});

	var im = $('.slider_image .slide_image').size();

	$('.slider_image .next1').click(function(){
		if ($('#im' + im).hasClass('current')){
			$('.slider_image .slide_image').removeClass('current');
			$('.slider_image .slide_image').eq(0).addClass('current');
		}
		else{
			$('.slider_image .current').removeClass('current').next('.slider_image .slide_image').addClass('current');
		}
		var num = $('.slider_image .current').attr('num');
		return false;
	});

	$('.slider_image .prev1').click(function(){
		if ($('.slider_image .slide_image').eq(0).hasClass('current')){
			$('.slider_image .slide_image').removeClass('current');
			$('.slider_image .slide_image').eq(im-1).addClass('current');
		}
		else{
			$('.slider_image .current').removeClass('current').prev('.slider_image .slide_image').addClass('current');
		}
		var num = $('.slider_image .current').attr('num');
		return false;
	});
});

var cur = $(this)
function logger(i, cur){
	$('.panel .box_log .tab a').removeClass('on');
	$(cur).addClass('on');
	$('.panel .box_log .form').hide();
	$('.panel #form' + i).show();
}

function show_tab(i, cur){
	$('.tabber .tab a').removeClass('current');
	$(cur).addClass('current');
	$('.tabber .tab_in').hide();
	$('.tabber #tab' + i).show();
}

function show(i, cur){
	$('.tab_link a').removeClass('current');
	$('.tab_link a').eq(0).css('z-index',10);
	$('.tab_link a').eq(1).css('z-index',9);
	$('.tab_link a').eq(2).css('z-index',8);
	$('.tab_link a').eq(3).css('z-index',7);
	$(cur).addClass('current');
	$(cur).css('z-index',15);
	$('.tab_page').hide();
	$('.tab_page#tab' + i).show();
}