var authorization = function()
{

	this.actions = {
		'ajaxLogout' : '/authorization/logout/',
		'ajaxGetAuthorizationBar' : '/authorization/ajaxGetAuthorizationBar/'
	}

	this.logoutAction = function()
	{
		var that = this;
//		var data = {
//			'client_logout' : $('#form1 .authorization_client_submit').val(),
//		};
		$.ajax({
//			before: (new cabinetHandler()).ajaxLoader.innerLoader((new cabinetHandler()).sources.loginForm),
			url: that.actions.ajaxLogout,
			type: 'POST',
//			data: data,
			success: function(data){
//				$( (new cabinetHandler()).sources.cabinetAuthorizated ).removeClass( (new cabinetHandler()).sources.cabinetAuthorizatedClassName )
//														.addClass( (new cabinetHandler()).sources.cabinetClassName );
//				$( (new cabinetHandler()).sources.loginForm ).hide();
//				(new cabinet()).redirectFromCabinetToIndex();
				if(data == 1){
					if(location.pathname == '/shopcart/')
						location.reload();
					else
						that.updateAuthorizationBar();
				}
			}
		});
	}

	this.updateAuthorizationBar = function()
	{
		var that = this;
		$.ajax({
			url: that.actions.ajaxGetAuthorizationBar,
			type: 'POST',
			success: function(data){
				$('.authorizationBar').html(data);
			}
		});
	}


//    this.getAuthorizationBlock = function()
//    {
//	var that = this;
//	$.ajax({
//		before: (new authorizationHandler()).ajaxLoader.innerLoader((new authorizationHandler()).sources.loginForm),
//		url: that.actions.getAuthorizationBlock,
//		type: 'POST',
//		success: function(data){
//			$((new authorizationHandler()).sources.loginForm).html(data);
//		}
//	});
//    }
//
//    this.processAuthorization = function()
//    {
//	var handlerAuthorization = new authorizationHandler();
//	var that = this;
//	var data = {
//		'login' : $('#form1 input[name="login"]').val(),
//		'password' : $('#form1 input[name="password"]').val(),
//		'cookie' : $('#form1 input[name="cookie"]').val(),
//		'authorization_client_submit' : $('#form1 .authorization_client_submit').val(),
//	};
//
//	$.ajax({
//		before:handlerAuthorization.ajaxLoader.setLoader(handlerAuthorization.sources.loginForm),
//		url: that.actions.ajaxAuthorization,
//		type: 'POST',
//		data: data,
//		dataType: 'json',
//		success: function(data){
//			handlerAuthorization.ajaxLoader.getElement();
//			if(data == 1){
//				(new cabinet()).getSuccessAuthorizatedCabinetBlock();
//				(new shopcart()).checkShopcartStatusAskSaving();
//			}
//			else
//				$( handlerAuthorization.sources.authorizationResultBlock ).html(data.errorMessage);
//		}
//	});
//    }
}