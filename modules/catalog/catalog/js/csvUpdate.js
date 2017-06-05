$(function(){
	$('.downloadCsv').click(function(){
		if( $('.dwnld [name=partnerId] option:selected').val() == 0 )
			return alert('Выберите партнера для генерации csv файла!');
		if( $('[name=fabricatorId] option:selected').val() == 0 )
			return alert('Выберите производителя для генерации csv файла!');
		return $('.dwnld').submit();
	});

	$('.uploadSubmit').click(function(){
		if( $('.uploadForm [name=partnerId] option:selected').val() == 0 )
			return alert('Выберите партнера для загрузки csv файла!');
		return $('.uploadForm').submit();
	});
});