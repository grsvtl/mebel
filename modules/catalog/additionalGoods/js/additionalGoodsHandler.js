$(function(){
    (new additionalGoodsHandler())
        .clickAddAdditionalGoodButton()
        .clickDeleteAdditionalGoodButton()
        .initAdditionalGoodAutosuggest();
});

var additionalGoodsHandler = function()
{
    this.sources = {
        'addAdditionalGoodButton' : '#addAdditionalGood',
        'additionalGoodId' : 'input[name=additionalGoodId]',
        'goodsTableBlock' : '.additionalGoodsTable',
        'deleteAdditionalGoodButton' : '.deleteAdditionalGood'
    };

    this.ajaxLoader = new ajaxLoader();

    this.clickAddAdditionalGoodButton = function()
    {
        var that = this;
        $(that.sources.addAdditionalGoodButton).live('click',function(){
            (new additionalGoods).addAdditionalGood(this);
        });
        return this;
    };

    this.clickDeleteAdditionalGoodButton = function()
    {
        var that = this;
        $(that.sources.deleteAdditionalGoodButton).live('click',function(){
            (new additionalGoods).deleteAdditionalGood(this);
        });
        return this;
    };

    this.initAdditionalGoodAutosuggest = function()
    {
        $('.inputAdditionalGoodId').autoSuggest('/admin/orderGoods/ajaxGetAutosuggestGoods/', {
            selectedItemProp: "name",
            searchObjProps: "name",
            targetInputName: 'additionalGoodId',
            secondItemAtribute: 'code',
            thirdItemAtribute: 'price',
            fifthItemAtribute: 'availability'
        });
        return this;
    }
};