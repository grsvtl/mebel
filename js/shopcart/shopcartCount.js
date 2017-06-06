ajaxGetShopcartCountRun();

function ajaxGetShopcartCountRun() {
    $.ajax({
        url: '/shopcart/ajaxGetShopcartCount/',
        type: 'POST',
        success: function(data){
            if($.isNumeric(data))
                $('.shopcartCount').html(data);
        }
    });
}