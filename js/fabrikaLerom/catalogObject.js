$(function(){

    // $('body').click(function(){
    //     $('.submenu').slideUp();
    //     $('.mitem').removeClass('on');
    // });

    $('select[name="productQuantity"]').on('change', function() {
        var that = this;
        $('span.itemQuantity').html(that.value);
    });

    $('a.getObjectModalButton').click(function () {
        var modalsBlock = $('.modalsBlock');
        var objectId = $(this).data('objectid');
        var modalForm = $('#objectModal'+objectId);

        if (modalForm.length == 0) {

            fetchObjectModalForm(objectId).done(
                function (data) {
                    modalsBlock.append(data['content']);
                    $('#objectModal'+objectId).modal('toggle');
                }
            );

        } else modalForm.modal('toggle');
    });

    function fetchObjectModalForm(_objectId){
        return $.ajax({
            url: '/catalog/ajaxGetCatalogListModalContentItemBlock/',
            type: 'POST',
            data: {
                'objectId' : _objectId
            },
            dataType: 'json'
        });
    }

    $(".select-main-block").click(function(e) {
        $('.list-select').toggle();
    });

    $('.line-select').click(function(e){
        e.stopPropagation();
        var color = $(this).find('span.choosedColor').html();
        $('.name-select').html(color);
        var colorId = $(this).find('span.choosedColor').attr('data-colorId');
        $('.addToShopcart').attr('data-objectColor', colorId);
        $('.list-select').hide();
    });
});