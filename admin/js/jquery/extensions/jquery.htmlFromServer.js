(function($){
	$.fn.htmlFromServer = function (settings) {
		var settings = $.extend(settings||{});
		var that = this;
		var onBeforeSend = function(){
			if ( typeof settings.loader == 'object' )
				settings.loader.start($(that));
		};

		var onComplete = function() {
			if ( typeof settings.loader == 'object' )
				settings.loader.stop($(that));

			if ($.isFunction(settings.callback))
				settings.callback();
		};

		var onSuccess = function(data){
			$(that).html(data);
		};

		var onError = function(xhr, status, error){
			alert(status);
		};

		if ( $(that).data('source') == undefined ) {
			alert('Пожалуйста добавьте к атрибут data-source к элементу, в который загружаете информацию!');
			return this;
		}

		var source = settings.source || $(that).data('source');

		$.ajax({
			url: source,
			beforeSend: onBeforeSend,
			type: 'POST',
			dataType: 'html',
			data: {'data' : $(that).data('data')},
			success: onSuccess,
			complete: onComplete,
			error: onError,
			async: false
		});
		return this;
	}
})(jQuery);