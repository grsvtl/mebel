$(function(){
    generateCapchaString();
});

function generateCapchaString() {
    $.ajax({
        // before: (new authorizationHandler()).ajaxLoader.innerLoader((new authorizationHandler()).sources.loginForm),
        url: '/feedback/ajaxGenerateCapchaString/',
        type: 'POST',
        dataType: 'json',
        success: function(data){
            if(data.res === true){
                $('.ajaxCapcha').html(data.capcha);
            }
            else
                alert('Произошла ошибка при попытке установить значение капчи. Обратитесь к владельцам сайта по эл. почте.');
        }
    });
}