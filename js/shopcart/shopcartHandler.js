$(function(){
	try {
		(new shopcartHandler)
			.addGoodInShopcart()
			.removeGoodFromShopcart()
			.onChangeQuantity()
			.showSubGoods()
			.acordeonInit()
			.getAuthorizationBlock()
			.closeAskModal()
			.personalInfoFormInit()
			.shopcartAction()
			.onDeliveryTypeChoose()
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
		'changeQuantity' : '.changeQuantity',
		'showSubGoodsButton' : '.showSubgoodsButton',
		'getAuthorizationBlockButton' : '.getAuthorizationBlock',
		'closeAskModalButton' : '.closeAskModal',
		'shopcartActionButton' : '.shopcartAction',
	};

	this.ajaxLoader = new ajaxLoader();

	this.addGoodInShopcart = function ()
	{
		var that = this;
		$(that.sources.addToShopcartButton).live('click', function(){
			that.shopcartObject.addToShopcart($(this));
			
			dataLayer.push({'event': 'event_addcart'});
                        console.log('event_addcart');
			
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

	this.onChangeQuantity = function ()
	{
		var that = this;
		$(that.sources.changeQuantity).live('click', function(){
			that.shopcartObject.changeQuantity($(this));
		});
		return this;
	};

	this.showSubGoods = function ()
	{
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

	this.acordeonInit = function ()
	{
		var that = this;
		$('.name-step').live('click', function(){
			$('.name-step').parent().addClass('passed');
			$(this).parent().removeClass('passed').hide().slideDown('slow');
		});
		return this;
	};

	this.getAuthorizationBlock = function()
	{
		var that = this;
		$(that.sources.getAuthorizationBlockButton).live('click', function(){
			$(this).hide();
			$(this).closest('.block-step').addClass('passed');
			$(this).closest('.block-step').next().removeClass('passed').slideDown('slow');
		});
		return this;
	};

	this.showPersonalDataBlock = function()
	{
		$('.reg-block').slideUp('slow');
		$('.enter-block').slideUp('slow');
		$('.personalInfo').slideDown('slow');
	}

	this.closeAskModal = function () {
		var that = this;
		$(that.sources.closeAskModalButton).live('click', function(){
			that.shopcartObject.closeAskModal();
			if(location.pathname == '/shopcart/')
				(new shopcartHandler).showPersonalDataBlock();
		});
		return this;
	};

	this.shopcartAction = function () {
		var that = this;
		$(that.sources.shopcartActionButton).live('click', function(){
			that.shopcartObject.shopcartAction($(this));
		});
		return this;
	};

	this.personalInfoFormInit = function()
	{
		console.log('personal init');
		var that = this;
		var personalInfoForm = new form();
		personalInfoForm.setSettings({'form':'.personalInfo'})
				.setCallback(function(response){
					if ( typeof response === 'number' )
						$('.deliveryShowButton').click();
				}).init();
		return this;
	}

	this.onDeliveryTypeChoose = function () {
		var that = this;
		$('.selfDeliveryButton').live('click', function(){
			$('.selfDeliveryBlock').slideDown('slow');
			$('.companyDeliveryBlock').hide();
		});
		$('.companyDeliveryButton').live('click', function(){
			$('.selfDeliveryBlock').hide();
			$('.companyDeliveryBlock').slideDown('slow');
		});
		return this;
	};
};
