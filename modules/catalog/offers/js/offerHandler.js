$(function(){
	(new offerHandler())
		.onChangeType()
		.onChangeDiscountType()
		.removeOfferGroupGoodFormInit();
});

var offerHandler = function()
{
	this.onChangeType = function()
	{
		$('select[name=type]').live('change',function(){
			var type = $(this + ':selected').val();
			$('.type').hide();
			$('input[name=' + type + ']').show();
		});
		return this;
	}

	this.onChangeDiscountType = function()
	{
		$('.discountType').live('change',function(){
			var discountType = $(this).val();
			$('.discountTypeInput').hide();
			$('.discountTypeInput').val(0);
			$('input[name=' + discountType + ']').show();
		});
		return this;
	}

	this.removeOfferGroupGoodFormInit = function()
	{
		var removeOfferGroupGoodForm = new form;
		removeOfferGroupGoodForm.setSettings({
				'form'    : '.removeOfferGroupGoodForm',
				'active'  : '.active',
				'message' : '.message'
			})
			.setCallback(function (data) {
				$('.offerGoodsTalbePlace').html(data);
				(new offerHandler()).removeOfferGroupGoodFormInit();
			})
			.init();
	}
}