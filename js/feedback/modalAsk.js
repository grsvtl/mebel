$(function (){
	var modal = new modalAsk();
	modal.init();

	var modalAskClick = new form;
	modalAskClick
			.setSettings({'form':'.modalAskClick'})
			.setCallback(function (response) {
				if (typeof response == "number") {
					modal.toggle();
                                        dataLayer.push({'event': 'event_question'});
                                        console.log('event_question');
				}
			})
			.init();

	$("input[name=phoneNumberAsk]").inputmask("mask", {"mask": "+9(999) 999-99-99"}); //specifying fn & options
});

var modalAsk = function () {
	this.settings = {
		'modalSuccessClass' : '.content',
		'modalWindowClass'  : '.modalAsk',
		'modalBgClass'      : '.modalAskBg',
		'modalCloseButton'  : '.close',
		'modalShowButton'   : '.modalAskShow',
	};

	this.init = function () {
		this.actions = {
			'showClickMonitoring'  : $.proxy(this.showClickMonitoring, this),
			'closeClickMonitoring' : $.proxy(this.closeClickMonitoring, this),
			'clickOnBgMonitoring'  : $.proxy(this.clickOnBgMonitoring, this)
		};
		var that = this;
		$.each(this.actions, function(){
			this.call(that);
		});
	};

	this.show = function (object) {
		$(this.settings.modalWindowClass).fadeIn();
		$(this.settings.modalBgClass).fadeIn();
	};

	this.close = function () {
		$(this.settings.modalWindowClass).fadeOut();
		$(this.settings.modalBgClass).fadeOut();
		(new errors).reset();
		if ( $(this.settings.modalWindowClass).find('form').is(':hidden') ) {
			$(this.settings.modalWindowClass).find(this.settings.modalSuccessClass).css('display', 'none');
			$(this.settings.modalWindowClass).find('form').css('display', 'block');
		}
	};

	this.closeClickMonitoring = function () {
		var that = this;
		$(this.settings.modalWindowClass).find(this.settings.modalCloseButton).click(function(){
			that.close();
			return false;
		});
	};

	this.clickOnBgMonitoring = function () {
		var that = this;
		$(this.settings.modalBgClass).click(function(){
			that.close();
			return false;
		});
	};

	this.showClickMonitoring = function () {
		var that = this;
		$(this.settings.modalShowButton).live('click', function(){
			that.show($(this));
			return false;
		});
	};

	this.toggle = function () {
		$(this.settings.modalWindowClass).find('input:visible').val('');
		$(this.settings.modalWindowClass).find('form').hide();
		$(this.settings.modalWindowClass).find(this.settings.modalSuccessClass).fadeIn();
	};
};