(function($){
	$.fn.autoScroll = function (options) {
		var settings = $.extend({
			'duration'   : '400',
			'paddingTop' : '0',
			'callback'   : null
		}, options||{});
		
        // //not supported for all versions start
        //
        // var dest = $(this).offset();
        // if (dest) {
			// dest = parseInt(dest.top) - parseInt(settings.paddingTop);
			// $('html,body').animate({scrollTop: dest}, settings.duration );
			// if($.isFunction(settings.callback))
			// 	settings.callback(this);
        // }
        //
        // //not supported for all versions end

        var dest = $(this)[0].offsetTop;
        if ($.isNumeric(dest)){
            dest = parseInt(dest) - parseInt(settings.paddingTop);
            $('html,body').animate({scrollTop: dest}, settings.duration );
            if($.isFunction(settings.callback))
                settings.callback(this);
        }
		
		return this;
	}
})(jQuery);