$(function(){

    $('button.cancelOrder').click(function(){
        window.location.href = "/";
    });

    $('a.btn.samovyvoz').click(function () {
        $('div.tab-pane.samovyvoz input').each(function(i, obj) {
            $(obj).attr('name', $(obj).data('name'));
        });

        $('div.tab-pane.vyvoz input').each(function(i, obj) {
            $(obj).attr('name', $(obj).data('namedefault'));
        });
    });

    $('a.btn.vyvoz').click(function () {
        $('div.tab-pane.vyvoz input').each(function(i, obj) {
            $(obj).attr('name', $(obj).data('name'));
        });

        $('div.tab-pane.samovyvoz input').each(function(i, obj) {
            $(obj).attr('name', $(obj).data('namedefault'));
        });
    });
});