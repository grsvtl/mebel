$(function(){
	$('.sortLinks').live('click', function(){
		var href = $(this).attr('href');
		var query = (href.indexOf('?') > -1)
						? $.deparam(href.slice(href.indexOf('?') + 1))
						: '';

		subPageStart(query);

		return false;
	});

	$('.sortLinks div').live('click', function(){
		var href = $(this).parent().attr('href');
		var query = (href.indexOf('?') > -1)
						? $.deparam(href.slice(href.indexOf('?') + 1))
						: '';

		subPageStart(query);

		return false;
	});

	$('.pagerElement a').live('click', function(){
		var href = $(this).attr('href');
		var query = (href.indexOf('?') > -1)
						? $.deparam(href.slice(href.indexOf('?') + 1))
						: '';

		subPageStart(query);

		return false;
	});

	$('.filter-button').live('click', function(){
		var hashString = '#' + 'minPrice=' + $("#slider-range").slider( "option", "values" )[0] + '&maxPrice=' + $("#slider-range").slider( "option", "values" )[1];

		if($('.word').val() != '')
			hashString += '&word=' + $('.word').val();

		var i=0;
		$('.type input:checkbox:checked').each(function(){
			hashString += '&' + $(this).attr('data-name') + '[' + i + ']=' + $(this).val();
			i++;
		});

		var i=0;
		$('.manufacturer input:checkbox:checked').each(function(){
			hashString += '&' + $(this).attr('data-name') + '[' + i + ']=' + $(this).val();
			i++;
		});

		var i=0;
		$('.seria input:checkbox:checked').each(function(){
			hashString += '&' + $(this).attr('data-name') + '[' + i + ']=' + $(this).val();
			i++;
		});

		hashString += '&sortBy[price]=down';

		changeLocation(hashString, $('.catalogListContent'));
	});

	$('.indexSearchButton').click(function(){
		var hashString = '#' + 'minPrice=' + $('.minPrice').val() + '&maxPrice=' + $('.maxPrice').val();
		if($('.fabricator').val())
			hashString += '&fabricator[0]=' + $('.fabricator').val();
		if($('.mainCategory').val())
			hashString += '&mainCategory[0]=' + $('.mainCategory').val();

		hashString += '&sortBy[price]=down';

		changeLocation(hashString, $('.filter'));
	});
});

var changeLocation = function(hashString, loaderBlock$)
{
	if(location.pathname == '/search/'){
		history.pushState('', '', location.pathname + hashString);
		var href = hashString;
		var query = (href.indexOf('#') > -1)
						? $.deparam(href.slice(href.indexOf('#') + 1))
						: '';
		subPageStart(query);
	}
	else{
		(new loaderBlock).init(loaderBlock$)
					.start();
		location.href = '/search/'  + hashString;
	}
}

var subPageStart = function(query)
{
	if(location.pathname == '/search/'){
		(new subPage).setQuery(query)
					.setQueryFromElementOrHash($('.catalogListContent'))
					.changeSearch();
	}
	else
		(new subPage).setQuery(query)
					.setQueryFromElementOrHash($('.catalogListContent'))
					.change();
}