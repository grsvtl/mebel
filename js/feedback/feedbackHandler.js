$(function(){
	(new feedbackHandler())
		.clickSendButton();
});

var feedbackHandler = function()
{
    this.sources = {
	'contactForm'	:   '.form_contact',
	'sendButton'	:   '.form_contact button',
	'clientName'	:   'input[name=clientName]',
	'phone'		:   'input[name=phone]',
	'email'		:   'input[name=email]',
	'captcha'		:   'input[name=captcha]',
	'textToSend'	:   'textarea[name=textToSend]',
	'messageSent'	:   '.messageSent'
    };

    this.ajaxLoader = new ajaxLoader();

    this.actions = {
	'sendMessage'	:   '/feedback/ajaxSendMessage/',
	'getContactsFormBlockAction' : '/feedback/getFeedbackContactBlock/'
    };

    this.clickSendButton = function()
    {
	var that = this;
	$(that.sources.sendButton).live('click',function(){
		$(that.sources.messageSent).hide();
		(new feedback).sendForm();
	});
    }

}