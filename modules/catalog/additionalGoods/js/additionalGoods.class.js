var additionalGoods = function()
{
    this.errors = new errors({
        'form' : '.addGoodBlock',
        'submit' : '#addAdditionalGood',
        'message' : '#message',
        'error' : '.hint',
        'showMessage' : true
    });

    this.actions = {
        'addAdditionalGood' : '/admin/additionalGoods/ajaxAddAdditionalGood/',
        'getAdditionalGoodsTable' : '/admin/additionalGoods/ajaxGetAdditionalGoodsTable/',
        'deleteAdditionalGood' : '/admin/additionalGoods/ajaxDeleteAdditionalGood/'
    };

    this.handler = new additionalGoodsHandler;

    this.addAdditionalGood = function(button)
    {
        var that = this;
        var goodId = $(button).attr('data-mainGoodId');
        var data ={
            'catalogItemId' : goodId,
            'additionalGoodId' : $(that.handler.sources.additionalGoodId).val()
        };
        $.ajax({
            before: that.handler.ajaxLoader.setLoader(that.handler.sources.addAdditionalGoodButton),
            url: that.actions.addAdditionalGood,
            type: 'POST',
            dataType: 'json',
            data: data,
            success: function(data){
                that.handler.ajaxLoader.getElement();
                if($.isNumeric(data)){
                    that.errors.reset();
                    that.resetAdditionalGoodsTable(goodId);
                }
                else{
                    that.errors.show(data);
                }
            }
        });
    }

    this.resetAdditionalGoodsTable = function(goodId)
    {
        var that = this;
        var data ={
            'goodId' : goodId
        };

        $.ajax({
            url: that.actions.getAdditionalGoodsTable,
            type: 'POST',
            dataType: 'html',
            data: data,
            success: function(data){
                $(that.handler.sources.goodsTableBlock).replaceWith(data);
                that.handler.initAdditionalGoodAutosuggest();
            }
        });
    }

    this.deleteAdditionalGood = function(deleteButton)
    {
        if (confirm('Удалить подтовар?')){
            var that = this;
            var data ={
                'additionalGoodId' : $(deleteButton).attr('data-id')
            };

            $.ajax({
                before: that.handler.ajaxLoader.setLoader(deleteButton),
                url: that.actions.deleteAdditionalGood,
                type: 'POST',
                dataType: 'json',
                data: data,
                success: function(data){
                    that.handler.ajaxLoader.getElement();
                    if($.isNumeric(data)){
                        that.errors.reset();
                        that.resetAdditionalGoodsTable($(that.handler.sources.addAdditionalGoodButton).attr('data-mainGoodId'));
                    }
                    else{
                        that.errors.show(data);
                    }
                }
            });
        }
    };
};