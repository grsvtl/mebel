$(function(){
	var editDelivery = new inputs;
	editDelivery
		.setSettings({'element' : '.editDelivery'})
		.setCallback(function (response) {
			if ( typeof response === 'number' ) {
				$('.deliveryEditBlock').remove();
				$('.deliveryContainer').htmlFromServer();
				$('.goodsTableList').htmlFromServer();
			} else
				alert(response);
		})
		.init();
});