$(function(){

//	$('.dostavka_but').live('click', function(){
//		var target = $(this).data('target');
//		var desc$  = $('.descript');
//		var resetDeliveries = function(){
//			$($(this).data('target')).html('');
//		};
//
//		desc$.fadeOut().remove();
//
//		$('.dostavka_but')
//				.removeClass('active')
//				.each(resetDeliveries);
//
//		$(this).addClass('active');
//
//		if ( $('.next').is(':hidden') ) {
//			$('.next').fadeIn();
//		}
//
//		$(target).htmlFromServer();
//	});
//
//
//	var objectAdd = new form;
//	objectAdd.setSettings({'form' : '.promoCodeForm'})
//			.setCallback(function (response) {
//				if (typeof response == "number")
//					$('.placeForShopcartGoodsTable').htmlFromServer();
//			}).init();
//
//	var promoDelete = new buttons;
//	promoDelete.setSettings({'element':'.buttonDelete'})
//			.setCallback(function (response) {
//				if (typeof response == "number")
//					$('.placeForShopcartGoodsTable').htmlFromServer();
//			}).init();
//
//		$('.deliveryPrice').live('blur',function(){
//		var income = $(this).val() - parseInt($('.deliveryBasePrice').text());
//		$('.deliveryIncome').text(income);
//	});
//
//	var deliveryCategories = new selects;
//	deliveryCategories
//		.setSettings({'element' : '.deliveryCategories', 'showError':false})
//		.setCallback(function (response) {
//			if (response != 1) {
//				var delivery$ = $('.deliveries');
//				delivery$.children().not(':first').remove();
//				$.each(response, function(){
//					delivery$.append($('<option></option>').val(this.value).text(this.name));
//				});
//				delivery$.fadeIn()
//						.removeAttr('disabled')
//						.children('option:first')
//						.text(
//							deliveryCategories.getChoosedObject()
//											.data('next_step_name')
//						);
//			} else {
//				$('.deliveries').html('').attr('disabled', 'disabled');
//			}
//			$('.deliveryAddressBlock').html('');
//		})
//		.init();
//
//	var deliveries = new selects;
//	deliveries
//		.setSettings({'element' : '.deliveries'})
//		.setCallback(function (response) {
//			if (response != 1) {
//				$('.deliveryAddressBlock').html(response);
//			} else {
//				$('.deliveryAddressBlock').fadeOut().html();
//			}
//		})
//		.init();
//
//	var deleteDelivery = new buttons();
//	deleteDelivery
//		.setSettings({
//			'element' : '.deleteOrderDelivery'
//		})
//		.setCallback(function (response) {
//			if (response === 1)
//				return (new order).resetOrderGoodsTableBlock();
//
//			alert('Delete delivery Error!');
// 		})
//		.init();

	try {
		(new shopcartHandler)
			.addGoodInShopcart()
			.removeGoodFromShopcart()
			.startOrdering()
			.shippingSelect()
			.sendOrderGetSuccessBlock()
			.onChangeQuantity()
			.showSubGoods()







//			.showShopcartModal()
//			.onGetAuthorizationContent()
//			.onGetMyOrderContent()
//			.onGetDeliveryContent()
//			.authorizateInShopcart()
//			.getRegistrationBlock()
//			.registrateInShopcart()
//			.saveDeliveryGetPayerContent()
//			.savePayerGetTotalContent()
//			.getPayerBlock()//
//			.birthdaySelectChange()
//			.closeAskModal()
//			.shopcartAction()
	} catch (e) {
		alert(e.message);
	}
});

var shopcartHandler = function () {

	this.shopcartObject = new shopcart;

	this.sources = {
		'addToShopcartButton'      : '.addToShopcart',
		'shopcartBar' : '.shopcartBar',
		'removeFromShopcartButton' : '.removeFromShopcart',
		'shopcartContent' : '.shopcartContent',
		'startOrderingButton' : '.startOrdering',
		'orderingBlock' : '.ordering',
		'shippingBlock' : '.shippingBlock',
		'liftBlock' : '.liftBlock',
		'shippingRadio' : '[name="shipping"]',
		'adresOrderBlock' : '.adresOrderBlock',
		'sendOrderGetSuccessBlockButton' : '.sendOrderGetSuccessBlock',
		'changeQuantity' : '.changeQuantity',
		'showSubGoodsButton' : '.showSubgoodsButton'






//		'getAuthorizationContentButton' : '.getAuthorizationContent',
//		'getMyOrderContentButton' : '.getMyOrderContent',
//		'getDeliveryContentButton' : '.getDeliveryContent',
//		'authorizateInShopcartButton' : '.authorizateInShopcart',
//		'getRegistrationBlockButton' : '.getRegistrationBlock',
//		'registrateInShopcartButton' : '.registrateInShopcart',
//		'saveDeliveryGetPayerContentButton' : '.saveDeliveryGetPayerContent',
//		'savePayerGetTotalContentButton' : '.savePayerGetTotalContent',
//		'getPayerBlockButton' : '.getPayerBlock',
//		'sendOrderGetSuccessBlockButton' : '.sendOrderGetSuccessBlock',
//		'birthdaySelect' : '.birthdaySelect',
//		'closeAskModalButton' : '.closeAskModal',
//		'shopcartActionButton' : '.shopcartAction',
	};

	this.ajaxLoader = new ajaxLoader();

	this.addGoodInShopcart = function ()
	{
		var that = this;
		$(that.sources.addToShopcartButton).live('click', function(){
			that.shopcartObject.addToShopcart($(this));
			
			if ( typeof dataLayer != 'undefined' )
				dataLayer.push({'event': 'event_addcart'});
			
		});
		return this;
	};

	this.removeGoodFromShopcart = function ()
	{
		var that = this;
		$(that.sources.removeFromShopcartButton).live('click', function(){
			that.shopcartObject.removeFromShopcart($(this));
		});
		return this;
	};

	this.startOrdering = function ()
	{
		var that = this;
		$(that.sources.startOrderingButton).live('click', function(){
			$(this).hide();
			$(that.sources.orderingBlock).show();
			
			dataLayer.push({'event': 'event_zakaz_start'});
			
		});
		return this;
	};

	this.shippingSelect = function()
	{
		var that = this;
		$(that.sources.shippingRadio).live('click', function(){
			that.shopcartObject.errorsSendOrder.reset();
			if($(this).attr('id') != 'shippingSelf'){
				$(that.sources.liftBlock).show();
				$(that.sources.adresOrderBlock).show();
			}
			else{
				$(that.sources.liftBlock).hide();
				$(that.sources.adresOrderBlock).hide();
			}
		});
		return this;
	}

	this.sendOrderGetSuccessBlock = function () {
		var that = this;
		$(that.sources.sendOrderGetSuccessBlockButton).live('click', function(){
			that.shopcartObject.sendOrderGetSuccessBlock($(this));
			
			dataLayer.push({'event': 'event_zakaz_done'});
                        console.log('event_zakaz_done');
			
		});
		return this;
	};

	this.onChangeQuantity = function () {
		var that = this;
		$(that.sources.changeQuantity).live('click', function(){
			that.shopcartObject.changeQuantity($(this));
		});
		return this;
	};

	this.showSubGoods = function () {
		var that = this;
		$(that.sources.showSubGoodsButton).live('click', function(){
			if($(this).html() == 'Показать комплектацию'){
				$(this).html('Скрыть комплектацию');
				$('.subGoods_' + $(this).attr('data-id')).show('slow');
			}
			else{
				$(this).html('Показать комплектацию');
				$('.subGoods_' + $(this).attr('data-id')).hide('slow');
			}
		});
		return this;
	};












//	this.showShopcartModal = function () {
//		var that = this;
//		$(that.sources.shopcartBar).live('click', function(){
//			that.shopcartObject.showShopcartModal();
//		});
//		return this;
//	};
//

//

//
//	this.onGetAuthorizationContent = function () {
//		var that = this;
//		$(that.sources.getAuthorizationContentButton).live('click', function(){
//			that.shopcartObject.getTemplateContent($(this), 'authorization');
//		});
//		return this;
//	};
//
//	this.onGetMyOrderContent = function () {
//		var that = this;
//		$(that.sources.getMyOrderContentButton).live('click', function(){
//			that.shopcartObject.getTemplateContent($(this), 'myOrder');
//		});
//		return this;
//	};
//
//	this.onGetDeliveryContent = function () {
//		var that = this;
//		$(that.sources.getDeliveryContentButton).live('click', function(){
//			that.shopcartObject.getTemplateContent($(this), 'delivery');
//		});
//		return this;
//	};
//
//	this.authorizateInShopcart = function () {
//		var that = this;
//		$(that.sources.authorizateInShopcartButton).live('click', function(){
//			that.shopcartObject.authorizateInShopcart($(this));
//		});
//		return this;
//	};
//
//	this.getRegistrationBlock = function () {
//		var that = this;
//		$(that.sources.getRegistrationBlockButton).live('click', function(){
//			that.shopcartObject.getRegistrationBlock($(this));
//		});
//		return this;
//	};
//
//	this.registrateInShopcart = function () {
//		var that = this;
//		$(that.sources.registrateInShopcartButton).live('click', function(){
//			that.shopcartObject.registrateInShopcart($(this));
//		});
//		return this;
//	};
//
//	this.saveDeliveryGetPayerContent = function () {
//		var that = this;
//		$(that.sources.saveDeliveryGetPayerContentButton).live('click', function(){
//			that.shopcartObject.saveDeliveryGetPayerContent($(this));
//		});
//		return this;
//	};
//
//	this.savePayerGetTotalContent = function () {
//		var that = this;
//		$(that.sources.savePayerGetTotalContentButton).live('click', function(){
//			that.shopcartObject.savePayerGetTotalContent($(this));
//		});
//		return this;
//	};
//
//	this.getPayerBlock = function () {
//		var that = this;
//		$(that.sources.getPayerBlockButton).live('click', function(){
//			that.shopcartObject.getTemplateContent($(this), 'payer');
//		});
//		return this;
//	};
//

//
//	this.birthdaySelectChange = function () {
//		var that = this;
//		$(that.sources.birthdaySelect).live('change', function(){
//			if( $('select[name=birthDate] :selected"').val() == 'Дата' )
//				$('select[name=birthDate]').css('color', '#B0B0B4');
//			else
//				$('select[name=birthDate]').css('color', 'black');
//
//			if( $('select[name=birthMonth] :selected"').val() == 'Месяц' )
//				$('select[name=birthMonth]').css('color', '#B0B0B4');
//			else
//				$('select[name=birthMonth]').css('color', 'black');
//
//			if( $('select[name=birthYear] :selected"').val() == 'Год' )
//				$('select[name=birthYear]').css('color', '#B0B0B4');
//			else
//				$('select[name=birthYear]').css('color', 'black');
//		});
//		return this;
//	};
//
//	this.closeAskModal = function () {
//		var that = this;
//		$(that.sources.closeAskModalButton).live('click', function(){
//			that.shopcartObject.closeAskModal();
//		});
//		return this;
//	};
//
//	this.shopcartAction = function () {
//		var that = this;
//		$(that.sources.shopcartActionButton).live('click', function(){
//			that.shopcartObject.shopcartAction($(this));
//		});
//		return this;
//	};
};
