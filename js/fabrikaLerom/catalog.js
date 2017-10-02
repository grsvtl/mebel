$(function(){

    try {
        var catalogObject = new catalog();
        catalogObject.enableTabWatcher();
        catalogObject.enableLoadMoreButtonWatcher();
        catalogObject.enableFormSubmitButton();
        catalogObject.enableModalFormButton();

        window.addEventListener('load',
            function() {

            }, false);


    } catch (e) {
        alert(e.message);
    }

});

var catalog = function () {

    const LOAD_MORE_GOODS_QUANTITY = 9;

    this.sources = {
        'checkMoreGoods': '/catalog/ajaxCheckMoreGoodsAvailable/',
        'fetchMoreGoods': '/catalog/ajaxFetchMoreGoods/',
        'fetchGoodModal': '/catalog/ajaxGetCatalogListModalContentItemBlock/'
    };

    this.ajaxLoader = new ajaxLoader();

    this.activeTab = 'composition';

    this.loadMoreButtonActive = {
        'composition': true,
        'modules': true
    };

    this.hideLoader = function () {
        this.ajaxLoader.getElement();
    };

    this.showLoader = function (object) {
        this.ajaxLoader.setLoader( object );
    };

    this.countLoadedGoods = function()
    {
        var that = this;

        return $("div#"+ that.activeTab + " div.productItemSingle").length;
    };

    function getLoadMoreButton()
    {
        return $('span.loadMoreButton');
    }

    this.enableTabWatcher = function ()
    {
        var that = this;

        $('ul.nav-tabs li').click(function () {
            that.activeTab = $(this).data('tab');
            that.switchButtonState();
        });
    };

    this.enableFormSubmitButton = function () {
        $('button.paramFilterButton').click(function () {
            $('form.paramFilterForm').submit();
        });
    };

    this.enableModalFormButton = function () {
        var that = this;
        var modalsBlock = $('.modalsBlock');

        $('a.getObjectModalButton').click(function () {
            var objectId = $(this).data('objectid');
            var modalForm = $('#objectModal'+objectId);

            if (modalForm.length == 0) {

                that.fetchObjectModalForm(objectId).done(
                    function (data) {
                        modalsBlock.append(data['content']);
                        $('#objectModal'+objectId).modal('toggle');
                    }
                );

            } else modalForm.modal('toggle');
        });
    };

    this.enableLoadMoreButtonWatcher = function () {
        var that = this;

        getLoadMoreButton().on('click', function () {
            //that.showLoader(getLoadMoreButton());
            that.switchButtonState();
            that.checkMoreGoodsAvailable().done(
                function (response) {
                    if (response == 1)
                        that.fetchMoreGoods().done(
                            function (data) {
                                if (data) {
                                    if (data['count'] < LOAD_MORE_GOODS_QUANTITY) {
                                        that.setInactiveButtonStateForCurrentTab();
                                        that.switchButtonState();
                                    }
                                    that.updateObjectsList(that.activeTab, data['content']);
                                    //that.hideLoader();
                                }
                            }
                        );
                    else {
                        that.setInactiveButtonStateForCurrentTab();
                        that.switchButtonState();
                    }
                }
            )
        });
    };

    this.switchButtonState = function () {
        this.loadMoreButtonActive[this.activeTab] == true ? getLoadMoreButton().css('visibility','inherit') : getLoadMoreButton().css('visibility','hidden');
    };

    this.setInactiveButtonStateForCurrentTab = function () {
        this.loadMoreButtonActive[this.activeTab] = false;
    };

    this.gatherPostData = function () {
        var _data = {
            'tab': this.activeTab,
            'loadedGoods': this.countLoadedGoods()
        };

        if ($('span.listLevel').data('value') == 'category')
            _data.categoryId = $('span.currentCategoryId').data('value');
        else {
            _data.level = 'search';
            _data.query = $('span.query').data('value');
        }
        return _data;
    };

    this.checkMoreGoodsAvailable = function () {
        var that = this;

        return $.ajax({
            url: that.sources.checkMoreGoods,
            data: that.gatherPostData(),
            type: 'POST'
        });
    };

    this.fetchMoreGoods = function () {
        var that = this;

        return $.ajax({
            url: that.sources.fetchMoreGoods,
            data: that.gatherPostData(),
            type: 'POST',
            dataType: 'json'
        });
    };

    this.fetchObjectModalForm = function (_objectId) {
        var that = this;

        return $.ajax({
            url: that.sources.fetchGoodModal,
            type: 'POST',
            data: {
                'objectId' : _objectId
            },
            dataType: 'json'
        });
    };

    this.updateObjectsList = function (tab, newContent)
    {
        var objectsList = $("div#" + tab + " > div.row");
        objectsList.append(newContent);
        $("div#" + tab + " div.productItemSingle").show('slow');
    };

};