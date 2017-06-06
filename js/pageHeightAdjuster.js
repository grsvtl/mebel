$(function(){
    adjustPageHeight();
    $( window ).resize(function() {
        adjustPageHeight();
    });
});

function adjustPageHeight() {
    var windowHeight = $(window).outerHeight(),
    mainElement = $('main'),
    mainElementOffsetTop = mainElement.offset().top,
    footer = $('footer#footer'),
    footerHeight = footer.outerHeight(),
    mainElementMinHeight = (windowHeight - footerHeight - mainElementOffsetTop);
    mainElement.css({ minHeight: mainElementMinHeight });
}