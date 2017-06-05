var shopcart = function (sources) {
	this.ajax = {
		'addToShopcart' : '/shopcart/ajaxAddGood/',
		'getShopcartBar' : '/shopcart/ajaxGetShopcartBar/',
		'removeFromShopcart' : '/shopcart/ajaxRemoveGood/',
		'getShopcartGoodsTable' : '/shopcart/ajaxGetShopcartGoodsTableContent/',
		'validateQuantity' : '/shopcart/ajaxValidateQuantity/',
		'changeQuantity' : '/shopcart/ajaxChangeQuantity/',
		'checkShopcartStatusAskSaving' : '/shopcart/ajaxCheckShopcartStatusAskSaving/',
		'checkPendingOrderExistAskSaving' : '/order/ajaxCheckPendingOrderExistAskSaving/',
		'controller' : '/shopcart/',
		'getShopcartPersonalDataBlock' : '/shopcart/ajaxGetShopcartPersonalDataBlock/'
	};

	this.loader = new ajaxLoader();

	this.errors  = new errors({
		'form' : '.main',
		'error'   : '.hint',
		'showMessage' : 'showMessage'
	});

	this.errorsSendOrder  = new errors({
		'form'	:	'.ordering',
		'error'   : '.hint',
		'showMessage' : 'showMessage'
	});

	this.errorsChangeQuantity  = new errors({
		'form'	:	'.main',
		'error'   : '.hint',
		'showMessage' : 'showMessage'
	});
//
//	this.errorsRegistration  = new errors({
//		'form'	:	'.registrationBlock',
//		'error'   : '.hint',
//		'showMessage' : 'showMessage'
//	});
//
//	this.errorsSavePersonalData  = new errors({
//		'form'	:	'.dostavka',
//		'error'   : '.hint',
//		'showMessage' : 'showMessage'
//	});
//


	this.addToShopcart = function (object) {
		var that = this;
		that.loader.setLoader( object );
		var quantity = 1;

		$.ajax({
			url: that.ajax.addToShopcart,
			type: 'POST',
			data: {
				'objectId' : $(object).attr('data-objectId'),
				'objectClass' : $(object).attr('data-objectClass'),
				'quantity' : quantity,
			},
			dataType: 'json',
			success: function(data){
				that.loader.getElement();
				if(data == 1){
					$('.okMessage').remove();
					object.after('<span class="okMessage">товар добавлен в корзину</span>').hide(0).delay('2500').show(0);
					$('.okMessage').show(0).delay(2000).fadeOut("slow");
					that.updateShopcartBar();
				}
				else
					alert('Error while trying to add good in shopcart');
			}
		});
	};

	this.updateShopcartBar = function()
	{
		var that = this;
		shopcartBar$ = $((new shopcartHandler()).sources.shopcartBar);
		$.ajax({
			url: that.ajax.getShopcartBar,
			type: 'POST',
			success: function(data){
				if(data)
					shopcartBar$.replaceWith(data);
				else
					alert('Error while trying to update shopcart bar');
			}
		});


	}

	this.removeFromShopcart = function (object) {
		var that = this;
		that.loader.setLoader( object );
		$.ajax({
			url: that.ajax.removeFromShopcart,
			type: 'POST',
			data: {
				'goodId' : $(object).attr('data-goodId'),
				'goodClass' : $(object).attr('data-goodClass'),
				'goodCode' : $(object).attr('data-goodCode'),
			},
			success: function(data){
				that.loader.getElement();
				if(data){
					that.updateShopcartGoodsTable();
					that.updateShopcartBar();
				}
				else
					alert('Error while trying to delete good from shopcart');
			}
		});
	};

	this.updateShopcartGoodsTable = function (callback) {
		var that = this;
		$.ajax({
			url: that.ajax.getShopcartGoodsTable,
			type: 'POST',
			data: {},
			dataType: 'html',
			success: function(data){
				if(data){
					$((new shopcartHandler()).sources.shopcartContent).replaceWith(data);
					if($.isFunction(callback))
						callback();
				}
				else
					alert('Error while trying to get shopcart goods table');
			}
		});
	};

	this.changeQuantity = function (object) {
		var that = this;
		that.loader.setLoader( object );
		$.ajax({
			url: that.ajax.validateQuantity,
			type: 'POST',
			dataType: 'json',
			data: {
				'goodId' : $(object).attr('data-goodId'),
				'goodClass' : $(object).attr('data-goodClass'),
				'goodCode' : $(object).attr('data-goodCode'),
				'quantity' : $(object).attr('data-quantity')
			},
			success: function(data){
				that.loader.getElement();
				if(data == 1){
					that.errorsChangeQuantity.reset();
					that.changeQuantityAction(object);
				}
				else
					that.errorsChangeQuantity.show(data);
			}
		});
	};

	this.changeQuantityAction = function (object) {
		var that = this;
		$.ajax({
			url: that.ajax.changeQuantity,
			type: 'POST',
			data: {
				'goodId' : $(object).attr('data-goodId'),
				'goodClass' : $(object).attr('data-goodClass'),
				'goodCode' : $(object).attr('data-goodCode'),
				'quantity' : $(object).attr('data-quantity')
			},
			success: function(data){
				if(data == 1){
					that.updateShopcartGoodsTable();
					that.updateShopcartBar();
				}
				else
					alert('Error while trying to change quantity in shopcart');

			}
		});
	};

	this.checkShopcartStatusAskSaving = function()
	{
		var that = this;
		$.ajax({
			url: that.ajax.checkShopcartStatusAskSaving,
			type: 'POST',
			dataType: 'json',
			success: function(data){
				if(data){
					$('.modalAskBg').show();
					$('.modalAskBg').after(data);
				}
				else
					(new shopcartHandler()).showPersonalDataBlock();
			}
		});
	}

	this.checkPendingOrderExistAskSaving = function()
	{
		var that = this;
		$.ajax({
			url: that.ajax.checkPendingOrderExistAskSaving,
			type: 'POST',
			dataType: 'json',
			success: function(data){
				if(data){
					$('.modalAskBg').show();
					$('.modalAskBg').after(data);
				}
				else
					(new shopcartHandler()).showPersonalDataBlock();
			}
		});
	}

	this.closeAskModal = function()
	{
		$('.modalAskBg').hide();
		$('.modal2').remove();
	}

	this.shopcartAction = function(object)
	{
		var that = this;
		$.ajax({
			url: that.ajax.controller + object.attr('data-action') + '/',
			type: 'POST',
			dataType: 'json',
			success: function(data){}
		});

		that.closeAskModal();
		that.updateShopcartGoodsTable(that.showHideGoodsTableSlowly());
	}

	this.showHideGoodsTableSlowly = function()
	{
		$('.name-step').first().click();

		$('.start-ordering').hide();
		$('.block-step:eq(0)').delay( 2000 ).slideUp(5000);
		window.setTimeout(function(){$('.name-step').first().parent().show().addClass('passed');}, 8000);

		$('.reg-block').hide();
		$('.enter-block').hide();
		$('.personalInfo').show();
		$('.name-step:eq(1)').parent().removeClass('passed').hide().delay( 5000 ).slideDown(5000);
	}

	this.updatePersonalDataBlock = function()
	{
		var that = this;
		$.ajax({
			url: that.ajax.getShopcartPersonalDataBlock,
			type: 'POST',
			dataType: 'html',
			success: function(data){
				if(data)
					$('.personalInfo').html(data);
			}
		});
	}


















//	this.getTemplateContent = function (object, template) {
//		var that = this;
//		that.loader.setLoader(object);
//		$.ajax({
//			url: that.ajax.getTemplateContent,
//			type: 'POST',
//			dataType: 'json',
//			data: {
//				'template' : template,
//			},
//			success: function(data){
//				that.loader.getElement();
//				if(data){
//					$('.basket_box').html(data);
//					that.errors.reset();
//				}
//				else
//					alert('Error while trying to get Content in shopcart');
//			}
//		});
//	};

//	this.showShopcartModal = function (elementToHide) {
//		var that = this;
//
//		that.loader.setLoader( (new shopcartHandler()).sources.shopcartBar );
//		$.ajax({
//			url: that.ajax.getShopcartModal,
//			type: 'POST',
//			data: {},
//			success: function(data){
//				that.loader.getElement();
//
//				$('.pop').show();
//				$('.modal').show();
//				$('.lightbox').hide();
//				$("html,body").css("overflow","hidden");
//
//				$('.placeForShopcart').html(data);
//
//				if(elementToHide)
//					$(elementToHide).hide();
//			}
//		});
//	};
//

//
//	this.updateShopcartGoodsTable = function () {
//		var that = this;
//		$.ajax({
//			url: that.ajax.getShopcartGoodsTable,
//			type: 'POST',
//			data: {},
//			dataType: 'html',
//			success: function(data){
//				if(data){
//					$('.placeForShopcartGoodsTable').html(data);
//				}
//				else
//					alert('Error while trying to get shopcart goods table');
//			}
//		});
//	};
//

//
//	this.getTemplateContent = function (object, template) {
//		var that = this;
//		that.loader.setLoader(object);
//		$.ajax({
//			url: that.ajax.getTemplateContent,
//			type: 'POST',
//			dataType: 'json',
//			data: {
//				'template' : template,
//			},
//			success: function(data){
//				that.loader.getElement();
//				if(data){
//					$('.basket_box').html(data);
//					that.errors.reset();
//				}
//				else
//					alert('Error while trying to get Content in shopcart');
//			}
//		});
//	};
//
//	this.authorizateInShopcart = function(object)
//	{
//		var that = this;
//		var data = {
//			'login' : $('#authorizateInShopcart input[name="login"]').val(),
//			'password' : $('#authorizateInShopcart input[name="password"]').val(),
//			'cookie' : $('#authorizateInShopcart input[name="cookie"]').val(),
//			'authorization_client_submit' : $('#authorizateInShopcart .authorization_client_submit').val(),
//		};
//
//		$.ajax({
//			url: (new authorization()).actions.ajaxAuthorization,
//			type: 'POST',
//			data: data,
//			dataType: 'json',
//			success: function(data){
//				if(data == 1){
//					that.getTemplateContent(object, 'delivery');
//					(new cabinet()).getSuccessAuthorizatedCabinetBlock();
//					that.checkShopcartStatusAskSaving();
//				}
//				else
//					$( (new authorizationHandler()).sources.authorizationResultBlock ).html(data.errorMessage);
//			}
//		});
//	}
//
//	this.getRegistrationBlock = function(object)
//	{
//		object.next().show();
//		object.hide();
//		$('.zaglushka').show();
//	}
//
//	this.registrateInShopcart = function(object)
//	{
//		var that = this;
//		var data = {
//			'login' : $('.registrationBlock input[name="login"]').val(),
//			'password' : $('.registrationBlock input[name="password"]').val(),
//			'passwordConfirm' : $('.registrationBlock input[name="passwordConfirm"]').val(),
//			'authorization_client_submit' : $('.registrationBlock .authorization_client_submit').val(),
//		};
//		$.ajax({
//			url: (new registration()).actions.ajaxRegistration,
//			type: 'POST',
//			data: data,
//			dataType: 'json',
//			success: function(data){
//				if( $.isNumeric(data) ){
//					that.errorsRegistration.reset();
//					(new cabinet()).getSuccessAuthorizatedCabinetBlock();
//					that.getTemplateContent(object, 'delivery');
//					that.saveGuestShopcartToAuthorizatedShopcart();
//				}
//				else
//					that.errorsRegistration.show(data);
//			}
//		});
//	}
//
//	this.saveDeliveryGetPayerContent = function(object){
//		var that = this;
//		var data = {
//			'deliveryCountry' : $('.dostavka select[name="deliveryCountry"] option:selected').val(),
//			'deliveryIndex' : $('.dostavka input[name="deliveryIndex"]').val(),
//			'deliveryRegion' : $('.dostavka input[name="deliveryRegion"]').val(),
//			'deliveryCity' : $('.dostavka input[name="deliveryCity"]').val(),
//			'deliveryStreet' : $('.dostavka input[name="deliveryStreet"]').val(),
//			'deliveryHome' : $('.dostavka input[name="deliveryHome"]').val(),
//			'deliveryBlock' : $('.dostavka input[name="deliveryBlock"]').val(),
//			'deliveryFlat' : $('.dostavka input[name="deliveryFlat"]').val(),
//			'deliveryPerson' : $('.dostavka input[name="deliveryPerson"]').val(),
//
//			'clientType' : 'phisic',
//			'notEmptyRules' : 'deliveryInformationNotEmpty',
//			'fields' : 'deliveryFields',
//			'flexibleAddress' : $('input[name=flexibleAddress]').val(),
//			'deliveryId' : $('.deliveries').val()
//		};
//		$.ajax({
//			url: that.ajax.saveStep2,
//			type: 'POST',
//			data: data,
//			dataType: 'json',
//			success: function(data){
//				that.loader.getElement();
//				that.errors.reset();
//				if(data === 1){
//					that.errorsSavePersonalData.reset();
//					that.getTemplateContent(object, 'payer');
//				}
//				else
//					that.errorsSavePersonalData.show(data);
//			},
//			error : function(response){
//				alert(response);
//			}
//		});
//	};
//
//	this.savePayerGetTotalContent = function(object){
//		var that = this;
//		var data = {
//			'name' : $('.dostavka input[name="name"]').val(),
//			'patronimic' : $('.dostavka input[name="patronimic"]').val(),
//			'surname' : $('.dostavka input[name="surname"]').val(),
//			'phone' : $('.dostavka input[name="phone"]').val(),
//			'mobile' : $('.dostavka input[name="mobile"]').val(),
//			'birthday' : $('.dostavka input[name="birthday"]').val(),
//			'birthDate' : $('.dostavka select[name="birthDate"]').val(),
//			'birthMonth' : $('.dostavka select[name="birthMonth"]').val(),
//			'birthYear' : $('.dostavka select[name="birthYear"]').val(),
//			'addEmails' : $('.dostavka textarea[name="addEmails"]').val(),
//
//			'clientType' : 'phisic',
//			'notEmptyRules' : 'payerInformationNotEmpty',
//			'fields' : 'payerFields',
//		};
//		$.ajax({
//			url: (new cabinet()).actions.ajaxSavePersonalData,
//			type: 'POST',
//			data: data,
//			dataType: 'json',
//			success: function(data){
//				that.loader.getElement();
//				that.errors.reset();
//				if(data == 1){
//					that.errorsSavePersonalData.reset();
//					that.getTemplateContent(object, 'total');
//				}
//				else{
//					if(data.name)
//						data.name = 'Укажите Ваше имя';
//					that.errorsSavePersonalData.show(data);
//				}
//			}
//		});
//	}
//

//
//	this.saveGuestShopcartToAuthorizatedShopcart = function(){
//		var that = this;
//		var data = {};
//		$.ajax({
//			url: that.ajax.saveGuestShopcartToAuthorizatedShopcart,
//			type: 'POST',
//			dataType: 'json',
//			success: function(data){}
//		});
//	}
//
//
//
//

}