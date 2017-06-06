$.ajax({
    url: '/article/ajaxGetFooterPhoneAllocaBlock/',
    type: 'POST',
    success: function(data){
        $('.footerPhoneAllocaPlace').html(data);
        allokaSubstitute();
    }
});