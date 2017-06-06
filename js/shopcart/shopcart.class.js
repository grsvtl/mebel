var shopcart = function (sources) {

    this.ajax = {
        'addToShopcart' : '/shopcart/ajaxAddGood/',
        'getShopcartBar' : '/shopcart/ajaxGetShopcartBar/',
        'removeFromShopcart' : '/shopcart/ajaxRemoveGood/',
        'getShopcartGoodsTable' : '/shopcart/ajaxGetShopcartGoodsTableContent/',
        'sendOrder' : '/order/add/',
        'validateQuantity' : '/shopcart/ajaxValidateQuantity/',
        'changeQuantity' : '/shopcart/ajaxChangeQuantity/'



//		'getShopcartModal' : '/shopcart/ajaxGetShopcartModal/',
//		'removeFromShopcart' : '/shopcart/ajaxRemoveGood/',
//		'getTemplateContent' : '/shopcart/ajaxGetTemplateContent/',
//		'saveGuestShopcartToAuthorizatedShopcart' : '/shopcart/ajaxSaveGuestShopcartToAuthorizatedShopcart/',
//		'checkShopcartStatusAskSaving' : '/shopcart/ajaxCheckShopcartStatusAskSaving/',
//		'saveStep2' : '/shopcart/saveStep2/',
//		'controller' : '/shopcart/'
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
        var objectId = $(object).attr('data-objectId');
        var isByeMoreQuantity = $('[data-objectId=' + objectId + '].byeMoreQuantity').length > 0;
        var quantity = 1;

        if( isByeMoreQuantity )
            quantity = $('[data-objectId=' + objectId + '].byeMoreQuantity').html();

        $.ajax({
            url: that.ajax.addToShopcart,
            type: 'POST',
            data: {
                'objectId' : objectId,
                'objectClass' : $(object).attr('data-objectClass'),
                'quantity' : quantity,
            },
            dataType: 'json',
            success: function(data){
                that.loader.getElement();
                if(data == 1){
                    that.updateShopcartBar();
                    if(isByeMoreQuantity)
                        that.updateByeMoreQuantityBlock(objectId);
                    if(typeof dataLayer != "undefined"){
                        if($(object).attr('data-dataLayerPushEvent') != "undefined")
                            if($(object).attr('data-dataLayerPushEvent') != ""){
                                dataLayer.push({"event": $(object).attr('data-dataLayerPushEvent')});
                                dataLayer.push({"event": '"' + $(object).attr('data-dataLayerPushEvent') + '"'});
                                console.log("event : " + $(object).attr('data-dataLayerPushEvent'));
                            }
                    }
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

    this.updateByeMoreQuantityBlock = function(objectId)
    {
        $.ajax({
            url: '/catalog/ajaxGetMinQuantity/',
            type: 'POST',
            data: {
                'id' : objectId
            },
            dataType: 'json',
            success: function(data){
                if($.isNumeric((data))){
                    $('[data-objectId=' + objectId + '].byeMoreQuantity').html(data);
                    changeQuantity(objectId, data);
                }
                else
                    alert('Error while trying to get min quantity in shopcart');
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

    this.updateShopcartGoodsTable = function () {
        var that = this;
        $.ajax({
            url: that.ajax.getShopcartGoodsTable,
            type: 'POST',
            data: {},
            dataType: 'html',
            success: function(data){
                if(data){
                    $((new shopcartHandler()).sources.shopcartContent).replaceWith(data);
                }
                else
                    alert('Error while trying to get shopcart goods table');
            }
        });
    };

    this.sendOrderGetSuccessBlock = function(object){
        var that = this;
        that.loader.setLoader(object);

        var shippingId = $('[name="shipping"]:checked').attr('id');
        var liftId = $('[name="lift"]:checked:visible').attr('id');

        var data = {
            'shipping' : $("label[for='"+shippingId+"']").html(),
            'name' : $('[name=name]').val(),
            'family' : $('[name=family]').val(),
            'parentName' : $('[name=parentName]').val(),
            'phone' : $('[name=phone]').val(),
            'addPhone' : $('[name=addPhone]').val(),
            'email' : $('[name=email]').val(),

            'lift' : $("label[for='"+liftId+"']").html(),
            'index' : $('[name=index]:visible').val(),
            'region' : $('[name=region]:visible').val(),
            'city' : $('[name=city]:visible').val(),
            'street' : $('[name=street]:visible').val(),
            'block' : $('[name=block]:visible').val(),
            'home' : $('[name=home]:visible').val(),
            'flat' : $('[name=flat]:visible').val(),
            'paymentType' : $('[name=paymentType]:visible').val(),

        };

        $.ajax({
            url: that.ajax.sendOrder,
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function(data){
                that.loader.getElement();
                if(data){
                    if( $.isNumeric(data)  ||  $.isNumeric(data.orderSum) ){
                        that.errorsSendOrder.reset();
                        $((new shopcartHandler()).sources.shopcartContent).hide();

                        if( $.isNumeric(data.orderSum) )
                            that.fillYandexPayForm(data);
                        else
                            $('.successBlockHybrid').show();

                        that.updateShopcartBar();
                        if(typeof dataLayer != "undefined"){
                            if(object.attr('data-dataLayerPushEvent') != "undefined")
                                if(object.attr('data-dataLayerPushEvent') != ""){
                                    dataLayer.push({"event": object.attr('data-dataLayerPushEvent')});
                                    dataLayer.push({"event": '"' + object.attr('data-dataLayerPushEvent') + '"'});
                                    console.log("event : " + object.attr('data-dataLayerPushEvent'));
                                }
                        }

                    }
                    else
                        that.errorsSendOrder.show(data);
                }
                else
                    alert('Error while trying to send order');
            }
        });
    };

    this.fillYandexPayForm = function (data) {
        $('.yandex_s_p').find('input[name="sum"]').val(data.orderSum);
        $('.yandex_s_p').find('.orderSum').html(data.orderSum);
        $('.yandex_s_p').find('input[name="customerNumber"]').val(data.orderName);
        $('.yandex_s_p').find('input[name="custName"]').val(data.orderPhone);
        $('.yandex_s_p').find('input[name="custEmail"]').val(data.orderEmail);
        $('.yandex_s_p').show();
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
//						data.name = 'РЈРєР°Р¶РёС‚Рµ Р’Р°С€Рµ РёРјСЏ';
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
//	this.checkShopcartStatusAskSaving = function()
//	{
//		var that = this;
//		$.ajax({
//			url: that.ajax.checkShopcartStatusAskSaving,
//			type: 'POST',
//			dataType: 'json',
//			success: function(data){
//				if(data){
//					$('.pop').show();
//					$('.placeForShopcart').after(data);
//				}
//			}
//		});
//	}
//
//	this.shopcartAction = function(action)
//	{
//		var that = this;
//		$.ajax({
//			url: that.ajax.controller + action.attr('data-action') + '/',
//			type: 'POST',
//			dataType: 'json',
//			success: function(data){}
//		});
//		that.closeAskModal();
//	}
//
//	this.closeAskModal = function()
//	{
//		$('.pop').hide();
//		$('.modal2').remove();
//	}
}