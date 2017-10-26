/**
 * Created by dmitricercel on 11.10.17.
 */
$(function () {

    $('#domainAlias, #categoryId, #seria').on('change', function () {
        $('#formFilters').submit();
    });
    var sort = new groupSorting();
    sort.sortable();

});


var groupSorting = function (settings) {
    this.settings = $.extend({
        'element$' : $('.sortable'),
        'helper' : 'clone',
        'handle' : '.current',
        'containment' : $('.itemsContainer'),
        'distance': 1,
        'axys' : '',
        'start' : function() {},
        'update' : function() {},
        'method' : 'post'
    }, settings||{});

    this.action = '/admin/catalogPriority/setGroupPriority/?';

    this.sortable = function () {
        this.settings.element$.sortable({
            helper: this.settings.helper,
            containment: this.settings.containment,
            start: $.proxy(this.start, this),
            update: $.proxy(this.update, this)
        });

        return this;
    };

    this.start = function(event, ui) {
        $('.ui-sortable-placeholder').css({'height': $('.thumbnail').parent().height()-20 });
        return this;
    };

    this.update = function(event, ui) {
        var query = '';
        var that = this;
        this.settings.element$.children( "div" ).each(function (i){
            if ($(this).data('id') !== undefined && $(this).data('priority') !== undefined) {
                ++i;
                if ( parseInt($(this).find('.priority').text()) !== i ) {
                    query += '&data['+$(this).data('id')+']='+i;
                    $(this).find('.priority').text(i).addClass('pulsate');
                }
            }
        });
        if ( $('#domainAlias').val() ) {
            query += '&domainAlias='+$('#domainAlias').val();
        }
        if ( $('#categoryId').val() ) {
            query += '&categoryId='+$('#categoryId').val();
        }

        this.savePriority(query);

        return this;
    };

    this.savePriority = function (query) {
        var that = this;
        $.ajax({
            beforeSend: $.proxy(that.before, that),
            error: $.proxy(that.error, that),
            url: that.action,
            type: that.method || 'post',
            data: query,
            dataType: 'json',
            success: $.proxy(that.success, that),
            complete: $.proxy(that.complete, that)
        });

        return this;
    };

    this.complete = function() {
        setTimeout(function () {
            $('.pulsate').removeClass('pulsate');
        }, 1000);
    };
};