$(function(){
	(new authorizationHandler())
	.toggleAuthorizationRegistrationBlocks()
	.authorizationFormInit()
	.registrationFormInit()
	.logout();
});

var authorizationHandler = function()
{
	this.sources = {
		'showAuthorizationBlockButton' : '.showAuthorizationBlock',
		'showRegistrationBlockButton' : '.showRegistrationBlock',
		'authorizationBlockCallBlock' : '.e-b-1',
		'authorizationBlock' : '.e-b-2',
		'registrationBlockCallBlock' : '.r-b-1',
		'registrationBlock' : '.r-b-2',
		'logoutButton' : '.logout'
	}

	this.ajaxLoader = new ajaxLoader();

	this.toggleAuthorizationRegistrationBlocks = function()
	{
		var that = this;
		$(that.sources.showAuthorizationBlockButton).live('click',function(){
			$(that.sources.authorizationBlockCallBlock).hide();
			$(that.sources.authorizationBlock).fadeIn('fast');
			$(that.sources.registrationBlockCallBlock).fadeIn('fast');
			$(that.sources.registrationBlock).hide();
			(new errors).reset();
		});
		$(that.sources.showRegistrationBlockButton).live('click',function(){
			$(that.sources.registrationBlockCallBlock).hide();
			$(that.sources.registrationBlock).fadeIn('fast');
			$(that.sources.authorizationBlockCallBlock).fadeIn('fast');
			$(that.sources.authorizationBlock).hide();
			(new errors).reset();
		});
		return this;
	}

	this.authorizationFormInit = function()
	{
		var that = this;
		var authInContent = new form();
		authInContent.setSettings({'form':'.authorizationFormInContent', 'showError': false})
				.setLoader(new loaderLight)
				.setCallback(function(response){
					if ( typeof response === 'number' ){
						(new authorization).updateAuthorizationBar();



//						(new shopcart()).checkShopcartStatusAskSaving();
						(new shopcart()).checkPendingOrderExistAskSaving();



						if(location.pathname == '/shopcart/')
							(new shopcart).updatePersonalDataBlock();
					}
					else
						$('.errorMessage').text(response.errorMessage).fadeIn(100).delay(1500).fadeOut(100);
				}).init();
		return this;
	}

	this.registrationFormInit = function()
	{
		var that = this;
		var regInContent = new form();
		regInContent.setSettings({'form':'.registrationFormInContent'})
				.setCallback(function(response){
					if ( typeof response === 'number' )
						(new authorization).updateAuthorizationBar();
				}).init();
		return this;
	}

	this.logout = function()
	{
		var that = this;
		$(that.sources.logoutButton).live('click', function(){
			(new authorization).logoutAction();
		});
		return this;
	}
}


