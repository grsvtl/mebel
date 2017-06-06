$(function () {
    var allHtml = document.documentElement.innerHTML;
    var findText1 = "Warning: unlink(/var/www/vnm/data/www/";
    var findText2 = "Предупреждение: unlink(/var/www/vnm/data/www/";
    if( allHtml.indexOf(findText1) >= 0   ||   allHtml.indexOf(findText2) >= 0 )
        location.reload();
});