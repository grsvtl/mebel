$(function(){
	var editDelivery = new inputs;
	editDelivery
		.setSettings({'element' : '.editDelivery'})
		.setCallback(function (response) {
			if ( typeof response === 'number' )
				(new subGoods).resetSubGoodsTable( $('#objectId').val() );
			else
				alert(response);
		})
		.init();
});