$(function(){
	(new settingsHandler())
		.clickClearCacheButton()
		.clickClearPageCacheButton()
});

var settingsHandler = function()
{
	this.sources = {
		'clearCacheButton' : '.clearCache',
		'clearCacheOkButton' : '.clearCacheOk',
		'clearPageCacheButton' : '.clearPageCache',
		'clearPageCacheOkButton' : '.clearPageCacheOk'
	};

	this.ajaxLoader = new ajaxLoader();

	this.clickClearCacheButton = function()
	{
		var that = this;
		$(that.sources.clearCacheButton).live('click',function(){
			(new settings).clearCache();
		});
		return this;
	};

	this.clickClearPageCacheButton = function()
	{
		var that = this;
		$(that.sources.clearPageCacheButton).live('click',function(){
			(new settings).clearPageCache();
		});
		return this;
	};
};