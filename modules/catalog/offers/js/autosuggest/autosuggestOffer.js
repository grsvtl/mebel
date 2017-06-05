$(function(){
	initGoodAutosuggest();
});

var initGoodAutosuggest = function(){
	$('.inputGoodId').autoSuggest('/admin/orderGoods/ajaxGetAutosuggestGoods/', {
		selectedItemProp: "name",
		searchObjProps: "name",
		targetInputName: 'goodId',
		secondItemAtribute: 'code',
		thirdItemAtribute: 'price',
		fourthItemAtribute: 'basePrice'
	});
}

var onSelectionAdded = function(targetInputName){
	if(targetInputName=='goodId')
		goodIdAdded(targetInputName);
}

var onSelectionRemoved = function(targetInputName){}

var goodIdAdded = function(targetInputName){
	var goodId = $('input[name=goodId]').val();
	var offerId = $('.objectId').val();
	var data = {goodId : goodId, offerId : offerId}
	$.ajax({
		before: $('.inputGoodLoader').show(),
		url: '/admin/offers/ajaxAddOfferGroupGood/',
		type: 'POST',
		dataType: 'json',
		data: data,
		success: function(data){
			$('.inputGoodLoader').hide();
			if(data){
				$('.offerGoodsTalbePlace').html(data);
				(new offerHandler()).removeOfferGroupGoodFormInit();
				$('.as-selection-item').remove();
				$('input[name=goodId]').val('');
			}
			else{
				alert('Произошла ошибка при попытке добавить товар к группе акций. Возможно этот товар уже добавлен в другую группу акций.  Если нет, обратитесь к разработчикам.');
			}
		}
	});
}