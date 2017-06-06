$(function(){
    $("[name='needDelivery']").change(function() {
        var $this = $(this);
        var needDelivery = $this.val() === 'true' ? true : false;

        if (needDelivery) {
            $(".delivery-block").removeClass('collapse');
        } else {
            $(".delivery-block").addClass('collapse');
        }

        $('.hint').remove();
    });
});