$(function(){
    $.ajax({
        url: '/shopcart/ajaxGetShopcartBarContent/',
        type: 'POST',
        dataType: 'json',
        success: function(data){
            if(data.res === true)
                $('.shopcartBarPlace').html(data.content);
            else
                alert('Произошла ошибка при попытке вывести корзину с товарами. Обратитесь к владельцам сайта по эл. почте.');
        }
    });
});