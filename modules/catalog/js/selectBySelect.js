$(function(){
	var selectBySelect = new selects;
	selectBySelect
		.setSettings({'element' : '.parametersCategories'})
		.setCallback(function (response) {
			if (response != 1) {
				var delivery$ = $('.parameters');
				delivery$.html('')
						.html(response)
						.fadeIn()
			}
		})
		.init();
});