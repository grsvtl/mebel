$(function (){
    var modal = new modalOrderOneClick();
    modal.init();

    var orderByOneClick = new form;
    orderByOneClick
        .setSettings({'form':'.orderByOneClick'})
        .setCallback(function (response) {
            if (typeof response == "number") {
                modal.toggle();
                if(typeof dataLayer != "undefined"){
                    if($(this.settings.form).attr('data-dataLayerPushEvent') != "undefined")
                        if($(this.settings.form).attr('data-dataLayerPushEvent') != ""){
                            dataLayer.push({"event": $(this.settings.form).attr('data-dataLayerPushEvent')});
                            dataLayer.push({"event": '"' + $(this.settings.form).attr('data-dataLayerPushEvent') + '"'});
                            console.log("event : " + $(this.settings.form).attr('data-dataLayerPushEvent'));
                        }
                }
            }
            else
                generateCapchaString();
        })
        .init();

    $("input[name=phoneNumber]").inputmask("mask", {"mask": "+7(999) 999-99-99"}); //specifying fn & options
});

var modalOrderOneClick = function () {
    this.settings = {
        'modalSuccessClass' : '.content',
        'modalWindowClass'  : '.orderOneClickModal,			.modalOrderOneClick',
        'modalBgClass'      : '.orderOneClickModalBg,		.callBackBg',
        'modalCloseButton'  : '.close,						.closeCallbackOneClick',
        'modalShowButton'   : '.orderOneClickModalShow',
        'goodIdAttribut'	: 'data-ObjectId',
        'goodIdInput'		: '.oneClickGoodId',
        'modalWindowTitle'	: '.oneClickTitle,				.titleCallBackBlockOneClock'
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
        var goodId = object.attr(this.settings.goodIdAttribut);
        $(this.settings.goodIdInput).val(goodId);
        $(this.settings.modalWindowTitle).html( object.attr('title') );

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
        $('body').on('click', this.settings.modalShowButton, function(){
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