$(function(){

//	$('body').on('keyup', function(e){
//		if(e.which == 13)
//			if($('.filter-button').isOnScreen())
////				if(!collision($('.filter-button'), $('*')))
////			$('.filter-button').click();
//					console.log(
//						'filter-button',
//						$('.filter-button').css('z-index') <= getMaxZ($('*')),
//						$('.filter-button').css('z-index'),
//						getMaxZ($('*'))
//					);
//	});
//
//	$('.filter').on('keyup', function(e){
//		if(e.which == 13)
////			$('.indexSearchButton').click();
//			console.log('indexSearchButton');
//	});
//
//	function getMaxZ(selector){
//		return Math.max.apply(null, $(selector).map(function(){
//			var z;
//			return isNaN(z = parseInt($(this).css("z-index"), 10)) ? 0 : z;
//		}));
//	};
//
//	$.fn.isOnScreen = function(){
//		var win = $(window);
//
//		var viewport = {
//			top : win.scrollTop(),
//			left : win.scrollLeft()
//		};
//		viewport.right = viewport.left + win.width();
//		viewport.bottom = viewport.top + win.height();
//
//		var bounds = this.offset();
//		bounds.right = bounds.left + this.outerWidth();
//		bounds.bottom = bounds.top + this.outerHeight();
//
//		return (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom));
//	};

    $('.filter').on('keyup', function(e){
        if(e.which == 13)
            $('.indexSearchButton').click();
    });

    $('.filters').on('keyup', function(e){
        if(e.which == 13)
            $('.filter-button').click();
    });

    $('body').on('click', '.filter-button', function(){
        var queryString = '?' + 'minPrice=' + $("#slider-range").slider( "option", "values" )[0] + '&maxPrice=' + $("#slider-range").slider( "option", "values" )[1];

        if($('.word').val() != '')
            queryString += '&word=' + $('.word').val();

        var i=0;
        $('.type input:checkbox:checked').each(function(){
            queryString += '&' + $(this).attr('data-name') + '[' + i + ']=' + $(this).val();
            i++;
        });

        var i=0;
        $('.manufacturer input:checkbox:checked').each(function(){
            queryString += '&' + $(this).attr('data-name') + '[' + i + ']=' + $(this).val();
            i++;
        });

        var i=0;
        $('.seria input:checkbox:checked').each(function(){
            queryString += '&' + $(this).attr('data-name') + '[' + i + ']=' + $(this).val();
            i++;
        });

//		queryString += '&sortBy[price]=down';

        location.href = '/search/'  + queryString;
    });

    $('.indexSearchButton').click(function(){
        var queryString = '?' + 'minPrice=' + $('.minPrice').val() + '&maxPrice=' + $('.maxPrice').val();
        if($('.fabricator').val())
            queryString += '&fabricator[0]=' + $('.fabricator').val();
        if($('.mainCategory').val())
            queryString += '&mainCategory[0]=' + $('.mainCategory').val();

//		hashString += '&sortBy[price]=down';

        location.href = '/search/'  + queryString;
    });

    $('.findButton').click(function(){
        if( $('.findInput').val() ){
            var queryString = '?' + 'word=' + $('.findInput').val();
            location.href = '/search/'  + queryString;
        }
    });

    $('.search').on('keyup', function(e){
        if(e.which == 13)
            $('.findButton').click();
    });
});