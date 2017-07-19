$(function () {
    $('.changePriceTrigger').on('click', function () {
        if(
            ($("[name='changePrice']").val()==="" && $( "[name='changeOldPrice']").val() === "")
            ||
            $("[name='changePriceSign']").val()===""
            ||
            $("[name='changePriceValue']").val()===""
            ||
            $("[name='changePriceCurrency']").val()===""
            ||
            !$.isNumeric( $("[name='changePriceValue']").val() )
            ||
            $("[name='changePriceValue']").val() == 0
        ){
            $('.changePriceErrorMessage').removeClass('hide');
            return;
        }

        $('.changePriceErrorMessage').addClass('hide');

        var changePriceLoader = (new loaderLight()).start();
        groupReset();
        createGroupBloks();
        $.ajax({
            url:'/admin/prices/changePrices',
            type : 'POST',
            data : (function () {
                var data = {};
                $('.changePrice').find('*').each(function(i, el) {
                    if(el.hasAttribute('name') && $(el).prop("type") != "button" && $(el).prop("type") != "submit"){
                        if ( ( $(el).prop("type") == "checkbox" || $(el).prop("type") == "radio" ) )
                            el.checked   ?   data[$(el).attr('name')] = 1   :   '';
                        else
                            data[$(el).attr('name')] = $(el).val();
                    }
                });
                $('#groupArray').find('input[type=hidden][name^=group].group').each(function(i, el) {
                    if(el.hasAttribute('value'))
                        data[$(el).attr('name')] = $(el).val();
                });
                return data;
            })(),
            success : function(res){
                changePriceLoader.stop();
                if(res == 1){
                    $( "#changePricesOkDialog" ).dialog({
                        position: {  my: "center", at: "center", of: window },
                        modal: true,
                        dialogClass: "ui-change-price-ok-dialog",
                        width: 550,
                        height:200
                    });
                }
                else
                    alert('Error while trying to change prices. Please contact developers.');
            }
        });
    });

    $('#roolBackPricesButton').on('click', function () {
        var changePriceLoader = (new loaderLight()).start();
        $.ajax({
            url : '/admin/prices/roolBackPrices/',
            type : 'POST',
            success : function (res) {
                changePriceLoader.stop();
                if(res == 1){
                    location.reload();
                }
                else
                    alert('Error while trying to roolback prices. Please contact developers.');
            }
        });
    });

    $('#deleteDumpFileButton').on('click', function () {
        var changePriceLoader = (new loaderLight()).start();
        $.ajax({
            url : '/admin/prices/deleteDumpFile/',
            type : 'POST',
            success : function (res) {
                changePriceLoader.stop();
                if(res == 1){
                    location.reload();
                }
                else
                    alert('Error while trying to delete prices dump file. Please contact developers.');
            }
        });
    });
});