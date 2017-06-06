$(function(){
	// var glide = $('.slider').glide().data('api_glide');
    //
	// $(window).on('keyup', function (key) {
	// 	if (key.keyCode === 13) {
	// 		glide.jump(3, console.log('Wooo!'));
	// 	};
	// });
    //
	// $('.slider-arrow').on('click', function() {
	// 	console.log(glide.current());
	// });

    $('.buttonMenu, .bgGrayMenu').click(function(){
        $('.mainContent').toggleClass('active');
    });

	$('.menuButton, .closeButton').click(function(){
        $('.mainMenu').toggleClass('active');
    });

	$('.findButton').click(function(){
		goToFindPage();
	});

	$('.findInput').keypress(function(e){
		if(e.keyCode==13)
			goToFindPage();
	 });

    // mark active in top menu, after cache page is loaded
    $('.mainMenuCenter').find('a[href="' + $(location).attr('pathname') + '"]').addClass('active');
    $('.mainMenuCenter').find('a[href="/skidki/"]').addClass('active');
});

function goToFindPage(){
	var find = $.trim($('.findInput').val());
	if(find.length)
		window.location.replace('/search/?find=' + find);
}