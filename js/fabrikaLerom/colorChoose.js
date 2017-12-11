$(function () {
    // $(".select-main-block").click(function() {
    $(document).on('click', '.select-main-block', function () {
        $('.list-select').toggle();
    });

    // $('.line-select').click(function(e){
    $(document).on('click', '.line-select', function (e) {
        e.stopPropagation();
        var color = $(this).find('span.choosedColor').html();
        $('.name-select').html(color);
        var colorId = $(this).find('span.choosedColor').attr('data-colorId');
        $('.addToShopcart').attr('data-objectColor', colorId);
        $('.list-select').hide();
    });
});