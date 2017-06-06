$.ajax({
    url: '/article/ajaxGetHeaderPhoneAllocaBlock/',
    type: 'POST',
    success: function(data){
        $('.headerPhoneAllocaPlace').html(data);
        var scriptService = document.createElement('script');
        scriptService.src = "https://analytics.alloka.ru/v4/alloka.js"
        scriptService.type = "text/javascript";
        scriptService.onload = function() {
            allokaInit();
        }
        document.getElementsByTagName("head")[0].appendChild(scriptService);
    }
});
