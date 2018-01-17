$(function () {
    $('.orderCall').click(function () {
        var modalForm = $('#modalOrderCall');
        modalForm.modal('toggle');
        modalForm.on('hidden.bs.modal', function () {
            $('.modalAskOkBlock').addClass('hidden');
            $('.hint').remove();
        })
    });

    $(".phoneInputP input").inputmask("mask", {"mask": "+7(999) 999-99-99"});

    var modalAsk = new form;
    modalAsk.setSettings({'form':'.modalAsk'})
        .setCallback(function (response) {
            if (response == 1) {
                $('[name=phoneNumberAsk]').val('');
                $('.modalAskOkBlock').removeClass('hidden').delay(5000).fadeOut( "slow" )
            }
        })
        .init();
});