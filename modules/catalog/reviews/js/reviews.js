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
        var myLoader = (new loader()).start();
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
                myLoader.stop();
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
    
    $('.deleteReview').on('click', function () {
        var myLoader = (new loader()).start();
        $.ajax({
            url: '/admin/reviews/delete/',
            type: 'POST',
            data: {'id' : $(this).attr('data-reviewId')},
            dataType : 'json',
            success: function(res){
                if($.isNumeric(res))
                    ajaxGetReviewsTableContent();
                else
                    alert('Error while try to delete review. Please contact developers.');
                myLoader.stop();
            }
        });
    });

    $('.addReview').on('click', function () {
        var that = this;
        var myLoader = (new loader()).start();
        $.ajax({
            url: '/admin/reviews/add/',
            type: 'POST',
            data: (function () {
                var data = {};
                $('.addReviewForm').find('*').each(function(i, el) {
                    if(el.hasAttribute('name') && $(el).prop("type") != "button" && $(el).prop("type") != "submit"){
                        if ( ( $(el).prop("type") == "checkbox" || $(el).prop("type") == "radio" ) )
                            el.checked   ?   data[$(el).attr('name')] = 1   :   '';
                        else
                            data[$(el).attr('name')] = $(el).val();
                    }
                });
                return data;
            })(),
            dataType : 'json',
            success: function(res){
                if($.isNumeric(res))
                    ajaxGetReviewsTableContent();
                else
                    (new errors()).setForm($('.addReviewForm')).show(res);
                myLoader.stop();
            }
        });
    });
    
    function ajaxGetReviewsTableContent() {
        $.ajax({
            url: '/admin/reviews/ajaxGetReviewsTableContent/',
            type: 'POST',
            data: {'domainInfoId' : $('input[name=domainInfoId]').val()},
            dataType : 'html',
            success: function(res){
                $('.placeForReviewsTableContent').html(res);
            }
        });
    }
});
