$(function(){
    var markerClass = 'inputTogglerMarker';
    var attributes = ['name', 'data-reviewId'];

    $('.currentReviews .toInput').click(function () {
        if($('body').find('.' + markerClass).length !== 0)
            return;
        (new InputToggler(this)).toInput(markerClass, attributes);
        blurInit();
    });

    function blurInit() {
        $('.' + markerClass).on('blur', function () {
            var that = this;
            var data = {'id' : $(this).attr('data-reviewId')};
            data[$(this).attr('name')] = $(this).val();
            var successCallback = function(){
                (new InputToggler($('.' + markerClass))).fromInput(attributes);
            };
            var errorCallback = function (res) {
                (new errors()).setForm($(that).parent()).show(res);
            };
            ajaxEdit(data, successCallback, errorCallback);
        });
    }

    function ajaxEdit(data, successCallback, errorCallback) {
        var loader = (new loaderLight()).start();
        (new errors()).reset();
        $.ajax({
            url: '/admin/reviews/edit/',
            type: 'POST',
            data: data,
            dataType : 'json',
            success: function(res){
                if($.isNumeric(res))
                    successCallback();
                else
                    errorCallback(res);
                loader.stop();
            }
        });
    }

    $('.goodsList .currentReviews textarea').on('blur', function () {
        var that = this;
        var data = {'id' : $(this).attr('data-reviewId')};
        data[$(this).attr('name')] = $(this).val();
        var successCallback = function(){};
        var errorCallback = function (res) {
            (new errors()).setForm($(that)).show(res);
        };
        ajaxEdit(data, successCallback, errorCallback);
    });

    $('.goodsList .currentReviews select').on('change', function () {
        var that = this;
        var data = {'id' : $(this).attr('data-reviewId')};
        data[$(this).attr('name')] = $(this).val();
        var successCallback = function(){};
        var errorCallback = function (res) {
            (new errors()).setForm($(that)).show(res);
        };
        ajaxEdit(data, successCallback, errorCallback);
    });
    
    // $('.deleteReview').on('click', function () {
    //     var loader = (new loaderLight()).start();
    //     $.ajax({
    //         url: '/admin/reviews/delete/',
    //         type: 'POST',
    //         data: {'id' : $(this).attr('data-reviewId')},
    //         dataType : 'json',
    //         success: function(res){
    //             if($.isNumeric(res))
    //
    //
    //
    //                 console.log('ok');
    //
    //
    //
    //
    //             else
    //                 alert('Error while try to delete review. Please contact developers.');
    //             loader.stop();
    //         }
    //     });
    // });

    $('.addReview').on('click', function () {

        console.log('ssssssss');

        var that = this;
        var margin = $(this).css('margin');
        $(this).css('margin', '5px 0px 0px 0px');
        setTimeout(function() { $(that).css('margin', '0px') }, 100);

        var data;
        $('.addReviewForm').find('*').each(function (i, el) {
            if(el.hasAttribute('name')){
                if($(this)[0].hasAttribute('val'))
                    data[$(this).attr('name')] = $(this).val();
                else
                    data[$(this).attr('name')] = $(this).html;
            }
        });
        console.log( 'ddddddddddd', data );

        // var loader = (new loaderLight()).start();
        // $.ajax({
        //     url: '/admin/reviews/add/',
        //     type: 'POST',
        //     data: {'id' : $(this).attr('data-reviewId')},
        //     dataType : 'json',
        //     success: function(res){
        //         if($.isNumeric(res))
        //             console.log('ok');
        //         else
        //             alert('Error while try to delete review. Please contact developers.');
        //         loader.stop();
        //
        //     }
        // });
    });
});
