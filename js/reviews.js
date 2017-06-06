$(function(){
	var sendReview = new form;
	sendReview.setSettings({
		'form' : '.sendReview',
		'onBeforeSend' : function() {
            $('.sendCommentLoader').removeClass('hide');
            $('.sendCommentResult').addClass('hide');
        }
	}).setCallback(function (response) {
        var callback = function () {
            $('.sendReview').find('textarea').val('');
            $('.sendReview').find('input').val('');
            $('.sendCommentResult').removeClass('hide');
        }
        if($.isNumeric(response))
            sendReviewPhoto(response, callback);
        $('.sendCommentLoader').hide()
	}).init();
});

function sendReviewPhoto(reviewId, callback) {
    var inpuPhoto = $('input[type=file][name=photo]');
    var data = new FormData();
    data.append( 'reviewId', reviewId );
    var files = inpuPhoto[0].files;
    $.each( files, function( key, value ){
        data.append( key, value );
    });

    $.ajax({
        url: '/article/sendReviewPhoto/',
        type: 'POST',
        data: data,
        cache: false,
        dataType: 'json',
        processData: false,
        contentType: false,
        success: function(response){
            if( response === 1 ){
                callback();
                inpuPhoto.val('');
            }
            else
                alert('Error while trying to save photo');
        },
        error: function(response){
            alert('Error while trying to save photo');
        }
    });
}