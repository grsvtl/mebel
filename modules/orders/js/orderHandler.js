$(function(){
	
	var changePartner = new selects;
	changePartner
		.setSettings({'element' : '.changePartner', 'event': 'change' })
		.setCallback(function (response) {
			if ( typeof response === 'number' )
				$('[name=cashRate]').val(response);
			else
				alert(response);
		})
		.init();
	
	
	$('.deliveryPrice').live('blur',function(){
		var income = $(this).val() - $('.deliveryBasePrice').val();
		$('.deliveryIncome').text(income);
	});
	$('.deliveryBasePrice').live('blur',function(){
		var income = $('.deliveryPrice').val() - $(this).val();
		$('.deliveryIncome').text(income);
	});
	
	var deliveryCategories = new selects;
	deliveryCategories
		.setSettings({'element' : '.deliveryCategories', 'showError':false})
		.setCallback(function (response) {
			if (response != 1) {
				var delivery$ = $('.deliveries');
				delivery$.children().not(':first').remove();
				$.each(response, function(){
					delivery$.append($('<option></option>').val(this.value).text(this.name));
				});
				delivery$.fadeIn()
						.children('option:first')
						.text(
							deliveryCategories.getChoosedObject()
											.data('next_step_name')
						);	
			} else {
				$('.deliveries').html('').fadeOut();
			}
			$('.deliveryAddressBlock').html('');
			$('.deliveryFormAddSubmit').attr('disabled', true)
		})
		.init();

	var deliveries = new selects;
	deliveries
		.setSettings({'element' : '.deliveries'})
		.setCallback(function (response) {
			$('.deliveryAddressBlock').html(response);
			$('.deliveryFormAddSubmit').removeAttr('disabled');
		})
		.init();

	var deleteDelivery = new buttons();
	deleteDelivery
		.setSettings({
			'element' : '.deleteOrderDelivery'
		})
		.setCallback(function (response) {
			if (response === 1)
				return (new order).resetOrderGoodsTableBlock();
			
			alert('Delete delivery Error!');
 		})
		.init();

	var deliveryForm = new form;
	deliveryForm
		.setSettings({'form' : '.deliveryFormAdd'})
		.setCallback(function (response) {
			(new order).resetOrderGoodsTableBlock();
		})
		.init();
	
	(new orderHandler())
		.clickAddGoodButton()
		.clickDeleteGoodButton()
		.clickEditGoodButton()
		.clickEditGoodActionButton()
		.addPromoCodeToOrder()
		.removePromoCodeToOrder();
});

var orderHandler = function()
{
	this.sources = {
		'addGoodButton' : '#addGoodToOrder',
		'orderId' : '.objectId',
		'goodId' : 'input[name=goodId]',
		'quantity' : 'input[name=quantity]',
		'price' : 'input[name=price]',
		'basePrice' : 'input[name=basePrice]',
		'goodDescription' : 'textarea[name=goodDescription]',
		'goodsTableBlock' : '.goodsTable',
		'deleteGoodButton' : '.deleteOrderGood',
		'editGoodButton' : '.editOrderGood',
		'priceInput' : 'input[name=editPrice]',
		'basePriceInput' : 'input[name=editBasePrice]',
		'quantityInput' : 'input[name=editQuantity]',
		'goodDescriptionHidden' : 'textarea[name=goodDescriptionHidden]',
		'normalView' : '.normalView',
		'editView' : '.editView',
		'editGoodActionButton' : '.editOrderGoodAction',
		'addPromoCodeButton' : '#addPromoCode',
		'promoCodeInput' : '#promoCodeInput',
		'removePromoCodeButton' : '#deleteOrderPromoCode'
	};

	this.ajaxLoader = new ajaxLoader();

	this.clickAddGoodButton = function()
	{
		var that = this;
		$(that.sources.addGoodButton).live('click',function(){
			(new order).addGood();
		});
		return this;
	};

	this.clickDeleteGoodButton = function()
	{
		var that = this;
		$(that.sources.deleteGoodButton).live('click',function(){
			(new order).deleteGood( getGoodIdByDomObject( this ) );
		});
		return this;
	};

	this.clickEditGoodButton = function()
	{
		var that = this;
		$(that.sources.editGoodButton).live('click',function(){
			(new order).showEditGoodDomElements( getGoodIdByDomObject( this ) );
		});
		return this;
	};

	this.clickEditGoodActionButton = function()
	{
		var that = this;
		$(that.sources.editGoodActionButton).live('click',function(){
			(new order).editGood( getGoodIdByDomObject(this) );
		});
		return this;
	};
	
	this.addPromoCodeToOrder = function()
	{
		var that = this;
		$(that.sources.addPromoCodeButton).live('click',function(){
			(new order).addPromoCodeToOrder($(that.sources.promoCodeInput).val(), that.resetPromoCodeInput);
		});
		return this;
	};
	
	this.resetPromoCodeInput = function()
	{
		$((new orderHandler).sources.promoCodeInput).attr('value', '');
		return this;
	};
	
	this.removePromoCodeToOrder = function()
	{
		var that = this;
		$(that.sources.removePromoCodeButton).live('click',function(){
			(new order).removePromoCodeFromOrder();
		});
		return this;
	};
};

var getGoodIdByDomObject = function(object)
{
	return $(object).parent().parent().parent().attr('data-id');
};