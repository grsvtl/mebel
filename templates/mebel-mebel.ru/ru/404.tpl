<html>
	<head>
		<title>Вы набрали неправильный адрес страницы</title>
		<meta charset="utf-8">

		<link rel="stylesheet" href="/css/vn-mebel.ru/content/reset.css">
		<link rel="stylesheet" href="/css/vn-mebel.ru/content/articles/404.css">
	</head>
	<body>
		<div class="main404">
			<h2>Вы набрали неправильный адрес страницы.</h2>
			<p>Пожалуйста, перейдите на <a href="/">главную страницу</a> сайта или воспользуйтесь меню каталога приведённого ниже.</p>
			<div class="catalog404">
				<?if( !empty($this->getController('Catalog')->getMainCategoriesWhichHasChildren()) ):?>
				<?foreach($this->getController('Catalog')->getMainCategoriesWhichHasChildren() as $category):?>
				<a href="<?=$category->getPath()?>"><?=$category->getName()?></a>
				<?endforeach?>
				<?endif?>
				<div class="clear"></div>
			</div>
		</div>
		<div class="footer404">
			<div class="center-footer">
				<div class="left">
					<p>
						<span>8-495-662-98-74</span>
						Москва, ул. Пионеров 20
					</p>
				</div>
				<div class="center">
					<img src="/images/bg/logo-n-m.png">
					<span>© 2008-2014 vn-mebel.ru</span>
				</div>
				<div class="right">
					<a href="http://webdelo.org"></a>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</body>
</html>