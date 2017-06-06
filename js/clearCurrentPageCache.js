$(function(){
	$('.clearCurrentPageCache').click(function(e){
		e.preventDefault();
		$.ajax({
			url: window.location.href,
			type: 'POST',
			data: {'clearCurrentPageCache' : 'true'},
			success: function(res){
				if(res == 1)
					location.reload();
				else
					alert('Error while trying to clear curren page cache. Check authorization.');
			}
		});
	});
});