var loaderLight = function () {
    this.bgElementStyle = 'position:fixed;top:0;left:0;right:0;bottom:0;' +
                        'background-color: #ffffff;opacity: 0.5;z-index:9999999999;';
    this.bgElement = '<div style="' + this.bgElementStyle + '"></div>';

	this.start = function () {
		this.cursor = $(document.activeElement).css('cursor');
        $(document.activeElement).css('cursor', 'wait');
        $('body').append(this.bgElement);
		return this;
	};

	this.stop = function () {
		$(document.activeElement).css('cursor', this.cursor);
        $('[style*="' + this.bgElementStyle + '"]').remove();
		return this;
	};
};