$(function(){
	var hash = $.deparam(location.hash.replace('#',''));

	if(location.pathname == '/search/'  &&   (location.search != ''  ||   hash != undefined)){
		history.pushState('', '', location.pathname + location.search.replace('?', '#'));
		if ( hash != undefined )
			(new subPage).setQuery(hash).setQueryFromElementOrHash($('.catalogListContent')).changeSearch();
	}
	else
		if ( hash != undefined )
			(new subPage).setQuery(hash).setQueryFromElementOrHash($('.catalogListContent')).change();
});


var subPage = function ()
{
	this.setQueryFromElementOrHash = function(element$)
	{
		if ( element$.length == 0 ) {
			alert('Укажите пожалуйста элемент для получения фильтров по умолчанию!');
			return;
		}
		if ( typeof element$.data('get') == "undefined" ) {
			alert('Для выбранного элемента не указаны дополнительные параметры фильтрации!');
			return;
		}
		var get = element$.data('get');
		if(get == '')
			get = location.hash.replace('#','');

		var finalQuery = $.extend($.deparam(get), $.deparam(this.query));
		return this.setQuery(finalQuery);
	};

	this.setQuery = function(json){
		this.query = $.param(json);
		return this;
	};

	this.getQuery = function () {
		return this.query ? '?'+this.query : '' ;
	};

	this.setHash = function(json){
		if (typeof json.page == 'undefined')
			location.hash = location.hash.replace('page=1', '');

		location.hash = $.param(json);

		if(location.hash == '')
			history.pushState("", document.title, window.location.pathname + window.location.search);

		return this;
	};

	this.change = function(){
		var that = this;
		$('.catalogListContent').htmlFromServer({
			'source' : '/catalog/ajaxGetCatalogListContent/'+that.getQuery(),
			'loader' : (new loaderBlock).init($('.catalogListContent')),
			'callback': function(){
				that.setHash($.deparam(that.query));
				$('.catalogListContent').autoScroll();
			}
		});
		return this;
	};

	this.changeSearch = function(source){
		var that = this;
		$('.catalogListContent').htmlFromServer({
			'source' : '/catalog/ajaxGetSearchContent/'+that.getQuery(),
			'loader' : (new loaderBlock).init($('.catalogListContent')),
			'callback': function(){
				that.setHash($.deparam(that.query));
				$('.catalogListContent').autoScroll();
			}
		});
		return this;
	};

}