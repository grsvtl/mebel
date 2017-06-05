$(function(){
	filtersInit();
	pricesInit();
});

var filtersInit = function () {

	var loader = new loaderBlock;
	loader.init($('.filters'));

	$('.filters .type input').live('click', function(){
		$('.seriesPlace').addClass('hide');
		$.ajax({
			before: loader.start(),
			url: '/catalog/ajaxGetFilterBlockManufacturer/',
			type: 'POST',
			data: {'mainCategoriesId' : getMainCategoriesId()},
			dataType: 'html',
			success: function(data){
				$('.manufacturersPlace').replaceWith(data);
				$('.manufacturersPlace').removeClass('hide');
				loader.stop();
			}
		});
	});

	$('.filters .manufacturer input').live('click', function(){
		var manufacturersId = '';
		$('.filters .manufacturer input:checked').each(function(){
			manufacturersId += this.value + ',';
		});
		manufacturersId = manufacturersId.substring(0, manufacturersId.length - 1);

		$.ajax({
			before: loader.start(),
			url: '/catalog/ajaxGetFilterBlockSeries/',
			type: 'POST',
			data: {
				'manufacturersId' : manufacturersId,
				'mainCategoriesId' : getMainCategoriesId()
			},
			dataType: 'html',
			success: function(data){
				$('.seriesPlace').replaceWith(data);
				$('.seriesPlace').removeClass('hide');
				loader.stop();
			}
		});
	});




};

var getMainCategoriesId = function()
{
	var mainCategoriesId = '';
		$('.filters .type input:checked').each(function(){
			mainCategoriesId += this.value + ',';
		});
	return mainCategoriesId.substring(0, mainCategoriesId.length - 1);
}

var pricesInit = function () {
	var slider$ = $('#slider-range');
	var minPrice$ = $('.filters .price-filter .minPrice');
	var maxPrice$ = $('.filters .price-filter .maxPrice');

	var setPricePeriod = function(startPrice, endPrice) {
		minPrice$.val(startPrice);
		maxPrice$.val(endPrice);
	};

	minPrice$.live('keyup',function(){
		var current = parseInt($(this).val());
		var maxPrice = maxPrice$.val();

		slider$.slider({values:[ current, maxPrice ]});
	});

	maxPrice$.live('keyup',function(){
		var minPrice = parseInt(minPrice$.val());
		var current = parseInt($(this).val());
		slider$.slider({values:[ minPrice, current ]});
	});

	slider$.slider({
		range: true,
		min: slider$.data('min'),
		max: slider$.data('max'),
		values: [ slider$.data('choosed-min'), slider$.data('choosed-max') ],
		slide: function( event, ui ) {
			setPricePeriod(ui.values[ 0 ], ui.values[ 1 ]);
		},
		stop: function(){
//			$('.filtersFormSubmit').click();
		}
	});

	setPricePeriod(slider$.slider( "values", 0 ), slider$.slider( "values", 1 ));
};