var feedback = function()
{

    this.errors = new errors({
            'form'	:	'.form_contact',
            'submit'  : '.form_contact button',
            'message' : '#message',
            'error'   : '.hint',
            'showMessage' : 'showMessage'
    });

    this.sendForm = function()
    {
	var handlerFeedback = (new feedbackHandler);
	var that = this;

	var data ={
	    'clientName':   $(handlerFeedback.sources.clientName).val(),
	    'phone'	:   $(handlerFeedback.sources.phone).val(),
	    'email'	:   $(handlerFeedback.sources.email).val(),
	    'captcha'	:   $(handlerFeedback.sources.captcha).val(),
	    'textToSend':   $(handlerFeedback.sources.textToSend).val()
	};
	$.ajax({
		before: handlerFeedback.ajaxLoader.setLoader(handlerFeedback.sources.sendButton),
		url: handlerFeedback.actions.sendMessage,
		type: 'POST',
		dataType: 'json',
		data: data,
		success: function(data){
		    handlerFeedback.ajaxLoader.getElement();
			if(data == 1){
				that.errors.reset();
				that.resetContactsFormBlock();
			} else {
				that.errors.show(data);
			}
		}
	});
    }

	this.resetContactsFormBlock = function()
	{
		var handlerFeedback = (new feedbackHandler);
		var that = this;

		$.ajax({
			url: handlerFeedback.actions.getContactsFormBlockAction,
			type: 'POST',
			dataType: 'html',
			success: function(data){
				$(handlerFeedback.sources.contactForm).replaceWith(data);
				$(handlerFeedback.sources.messageSent).show();
			}
		});
	}
}


