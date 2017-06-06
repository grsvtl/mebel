$(function () {
    $('.slider-for').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        // arrows: true,
        asNavFor: '.slider-nav',
        autoplay: true,
        autoplaySpeed: 5000,
        swipeToSlide: true,
        infinite: false,
    });
    $('.slider-nav').slick({
        slidesToShow: $('.slick-slidesToShow').val(),
        slidesToScroll: 1,
        asNavFor: '.slider-for',
        // centerMode: true,
        focusOnSelect: true
    });
    $('.bigImage').gallery();
});