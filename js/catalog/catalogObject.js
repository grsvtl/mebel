$(function(){
	initTabs();
	initTouchslider();
	initFeedback();
    initReviewAdd();
});

var initTabs = function()
{
	$('.tabs').live('click', function(){
		if($(this).is('a'))
			$('body,html').animate({scrollTop: 0}, 800);

		$('.tabs').removeClass('select');
		$('span.tabs[data-target=' + $(this).attr('data-target') + ']').addClass('select');
		$('.target').fadeOut('fast');
		$('.' + $(this).attr('data-target')).fadeIn('fast');
	});
}

var initTouchslider = function()
{
	$(".touchslider").touchSlider({margin: 0});
	$('.touchslider-nav-item').live('click', function(){
		$(this).parents('ul').children('.private').removeClass('private');
		$(this).parent().addClass('private');
	});

	$('.bigImage').gallery();

	$('.size').on('click', function(){
		$('.touchslider-item.current').children('a').click();
	});

	$('.touchslider-nav ul li').click(function(){
		rightCrossMonitoring($(this));
		leftCrossMonitoring($(this));
	});


	var rightCrossMonitoring = function (element$) {
		var preview$   = $('.hidden-photo');
		var preImages$ = $('.hidden-photo ul');
		var image$ = element$;
		var imageLeft   = image$.offset().left;
		var previewLeft = preview$.offset().left;
		if ( imageLeft - 10 < previewLeft ) {
			var preImagesPosLeft = preImages$.position().left;
			var preImagesLeft = preImagesPosLeft  + image$.width() * 1.5;
			var index = preImages$.find(image$).index('.hidden-photo ul li');
			if ( index == 0 ) {
				preImages$.animate({ left: 0 }, 150);
			} else {
				preImages$.animate({ left: preImagesLeft }, 150);
			}
		}
		return this;
	};

	var leftCrossMonitoring = function (element$) {
		var preview$   = $('.hidden-photo');
		var preImages$ = $('.hidden-photo ul');
		var image$ = element$;
		var imageWidth = image$.width() + 5;
		var imageRight = (image$.offset().left + imageWidth ) - preview$.offset().left;
		var previewWidth = preview$.width();
		if ( imageRight + 10 >= previewWidth ) {
			var left = preImages$.position().left;
			if (  image$.index('.touchslider-nav ul li') !== $('.touchslider-nav ul li').length - 1  ) {
				left = left - imageWidth;
			} else if ( imageRight > previewWidth ) {
				left = left - ( imageRight - previewWidth );
			}
			preImages$.animate({ left: left }, 150);
		}
		return this;
	};
};

var initFeedback = function()
{
	var feedback = new form;
	feedback.setSettings({'form' : '.feedback'})
		.setCallback(function (response) {
			if(response == 1){
				$('.feedbackBlockPlace').htmlFromServer();
				$('.okFeedback').show();
				initFeedback();
			}
			else
				$('.okFeedback').hide();
		})
		.init();
};

var initReviewAdd = function()
{
    var reviewAddErrors = new errors({'form' : '.reviewAdd'});
    var reviewAdd = new form;
    reviewAdd.setSettings({'form' : '.reviewAdd'})
        .setCallback(function (response) {
            if(response == 1){
                reviewAddErrors.reset();
                $('.okReviewAdd').show();
                $('.reviewAdd').find("input:visible,textarea,select").val('');
            }
            else{
                reviewAddErrors.show(response);
                $('.okReviewAdd').hide();
            }
        })
        .init();
}