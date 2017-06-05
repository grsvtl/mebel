$(function(){
	$('.more-text').click(function(){
		var text = $(this).text();
		var div$ = $('.descriptionText');
		var height = 0;
		div$.children('p').each(function(){
			height += $(this).outerHeight(true);
		});

		if ( $(this).data('expanded') === undefined ) {
			$(this).data('expanded', div$.height());
		} else {
			height = $(this).data('expanded');
			$(this).removeData('expanded');
		}

		div$.animate({ height: height }, 'fast');
		$(this).text($(this).data('text'));
		$(this).data('text', text);

		return false;
	});

	var expandDescription = function(){
		var desc$ = $('.descriptionText');
		var textHeight = 0;
		desc$.children('p').each(function(){
			textHeight += $(this).outerHeight(true);
		});
		var divHeight = desc$.height();

		if ( textHeight > divHeight ) {
			$('.more-text').fadeIn();
		}
	};

	var switchHandller = function()
	{
		var div$ = $('.descriptionText');
		var height = 0;
		div$.children('p').each(function(){
			height += $(this).outerHeight(true);
		});
		var blockHeight = $('.descriptionText').height();
		if(height < blockHeight)
			$('.more-text').hide();
	}

	expandDescription();
	switchHandller();
});