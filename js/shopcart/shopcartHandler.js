$(function(){
    try {
        (new shopcartHandler)
            .addGoodInShopcart()
            .removeGoodFromShopcart()
            .startOrdering()
            .shippingSelect()
            .sendOrderGetSuccessBlock()
            .onChangeQuantity()
            .showSubGoods()
    } catch (e) {
        alert(e.message);
    }

    $('.payAfter').click(function () {
        $('.yandex_s_p').hide();
        $('.successBlockHybrid').show();
    });

});

var shopcartHandler = function () {

    this.shopcartObject = new shopcart;

    this.sources = {
        'addToShopcartButton'      : '.addToShopcart',
        'shopcartBar' : '.shopcartBar',
        'removeFromShopcartButton' : '.removeFromShopcart',
        'shopcartContent' : '.shopcartContent',
        'startOrderingButton' : '.startOrdering',
        'orderingBlock' : '.ordering',
        'shippingBlock' : '.shippingBlock',
        'liftBlock' : '.liftBlock',
        'shippingRadio' : '[name="shipping"]',
        'adresOrderBlock' : '.adresOrderBlock',
        'sendOrderGetSuccessBlockButton' : '.sendOrderGetSuccessBlock',
        'changeQuantity' : '.changeQuantity',
        'showSubGoodsButton' : '.showSubgoodsButton'
    };

    this.ajaxLoader = new ajaxLoader();

    this.addGoodInShopcart = function ()
    {
        var that = this;
        $('body').on('click', that.sources.addToShopcartButton, function(){
            that.shopcartObject.addToShopcart($(this));
        });
        return this;
    };

    this.removeGoodFromShopcart = function ()
    {
        var that = this;
        $('body').on('click', that.sources.removeFromShopcartButton, function(){
            that.shopcartObject.removeFromShopcart($(this));
        });
        return this;
    };

    this.startOrdering = function ()
    {
        var that = this;
        $('body').on('click', that.sources.startOrderingButton, function(){
            $(this).hide();
            $(that.sources.orderingBlock).show();
        });
        return this;
    };

    this.shippingSelect = function()
    {
        var that = this;
        $('body').on('click', that.sources.shippingRadio, function(){
            that.shopcartObject.errorsSendOrder.reset();
            if($(this).attr('id') != 'shippingSelf'){
                $(that.sources.liftBlock).show();
                $(that.sources.adresOrderBlock).show();
            }
            else{
                $(that.sources.liftBlock).hide();
                $(that.sources.adresOrderBlock).hide();
            }
        });
        return this;
    }

    this.sendOrderGetSuccessBlock = function () {
        var that = this;
        $('body').on('click', that.sources.sendOrderGetSuccessBlockButton, function(){
            that.shopcartObject.sendOrderGetSuccessBlock($(this));
        });
        return this;
    };

    this.onChangeQuantity = function () {
        var that = this;
        $('body').on('click', that.sources.changeQuantity, function(){
            that.shopcartObject.changeQuantity($(this));
        });
        return this;
    };

    this.showSubGoods = function () {
        var that = this;
        $('body').on('click', that.sources.showSubGoodsButton, function(){
            if($(this).html() == 'Показать комплектацию'){
                $(this).html('Скрыть комплектацию');
                $('.subGoods_' + $(this).attr('data-id')).show('slow');
            }
            else{
                $(this).html('Показать комплектацию');
                $('.subGoods_' + $(this).attr('data-id')).hide('slow');
            }
        });
        return this;
    };
};