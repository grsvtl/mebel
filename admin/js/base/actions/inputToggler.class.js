function InputToggler(element){
    this.toInput = function(markerClass, attributes){
        if($(element).find('.' + markerClass).length !== 0)
            return;
        var newElement = '<input type="text" value="'+ $(element).html() +'">';
        $(element).html( newElement );
        $($(element).find('input'))
                    .addClass(markerClass)
                    .focus();

        $.each(attributes, function (i, el) {
            $($(element).find('input')).attr(el, $(element).attr(el));
            $(element).removeAttr(el);
        });
    };

    this.fromInput = function (attributes) {
        var content = $(element).val();
        $.each(attributes, function (i, el) {
            $($(element).parent()).attr(el, $(element).attr(el));
        });
        $(element).replaceWith(content);
    };
};