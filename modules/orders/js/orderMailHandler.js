$(function(){
	(new orderMailHandler())
		.initAjaxModal();
});

var orderMailHandler = function()
{
	this.sources = {
		'alertPartnerButton' : '.alertPartner',
		'orderId' : '.objectId',
		'aditionalMessage' : '.aditionalMessage',
		'copyToAdmin' : '.copyToAdmin',
		'loader' : '#ajax_bg',
		'buttonsClass' : '.ui-button',
		'modalWindow' : '.ui-dialog',
		'modalContainer' : '.modalContainer',
		'partnerHistory' : '.partnerHistory',
		'time' : 'input.time',
		'partnerNotifiedCheckbox' : '[name=partnerNotified]'
	};

	this.ajax = {
		'ajaxAlertPartner' : '/admin/orders/ajaxAlertPartner/',
	};

	this.initAjaxModal = function()
	{
		var that = this;
		(new ajaxModal).init({
			'button': that.sources.alertPartnerButton,
			'dialog' : {
				'title' : 'Отправка оповещения партнеру',
				'modal' : true,
				'zIndex': 400,
				'width' : 'auto',
				'buttons' : {
					"Отправить оповещение" : function () {
						(new orderMail).alertPartnerSend();
					},
					"Закрыть" : function () {
						$(this).dialog('close');
					}
				},
				open: function(  ) {
					if($('.noPartnerId').length>0)
						$('.ui-dialog-buttonpane').hide();
				}
			}
		});

		$('.ui-dialog').live("dialogclose", function(){
			$('.modalContainer').remove();
		});

		return this;
	}

}